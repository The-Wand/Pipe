///
/// Copyright 2020 Alexander Kozin
///
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
///
///     http://www.apache.org/licenses/LICENSE-2.0
///
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.
///
/// Created by Alex Kozin
/// El Machine 🤖

import CoreBluetooth.CBPeripheral

extension CBPeripheral: Pipable {
    
}

@discardableResult
public
func |<T> (context: T, ask: Ask<CBPeripheral>) -> Pipe {

    let pipe = Pipe.attach(to: context)

    guard pipe.ask(for: ask) else {
        return pipe
    }

    let source: CBCentralManager = pipe.get()
    source | .while { (status: CBManagerState) -> Bool in
        guard status == .poweredOn else {
            return true
        }

        let services: [CBUUID]?         = pipe.get()
        let options: [String : Any]?    = pipe.get()

        source.scanForPeripherals(withServices: services,
                                  options: options)

        return false
    }

    ask.cleaner = {
        source.stopScan()
    }

    return pipe
}

@discardableResult
public
prefix func |(ask: Ask<CBPeripheral>) -> Pipe {
    Pipe() | ask
}

@discardableResult
public
prefix func |(handler: @escaping (CBPeripheral)->()) -> Pipe {
    Pipe() | .every(handler: handler)
}

@discardableResult
public
func |<T> (context: T, handler: @escaping (CBPeripheral)->()) -> Pipe {
    context | .every(handler: handler)
}

public
extension CBPeripheral {

    class Delegate: NSObject, CBPeripheralDelegate, Pipable {

        public
        func peripheral(_ peripheral: CBPeripheral,
                        didDiscoverServices error: Error?) {
            isPiped?.put(peripheral.services)
            //, error: error)
        }

        public
        func peripheral(_ peripheral: CBPeripheral,
                        didDiscoverCharacteristicsFor service: CBService,
                        error: Error?) {
            isPiped?.put(service.characteristics, key: service.uuid.uuidString)
            //, error: error)
        }

        public
        func peripheral(_ peripheral: CBPeripheral,
                        didUpdateValueFor characteristic: CBCharacteristic,
                        error: Error?) {
            isPiped?.put(characteristic, key: characteristic.uuid.uuidString)
            //, error: error)
        }

        public 
        func peripheral(_ peripheral: CBPeripheral,
                        didDiscoverDescriptorsFor characteristic: CBCharacteristic,
                        error: Error?) {
            isPiped?.put(characteristic.descriptors,
                         key: characteristic.uuid.uuidString)
        }
        
    }
    
}
