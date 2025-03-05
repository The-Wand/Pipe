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

import CoreBluetooth.CBCentralManager

extension CBCentralManager: Constructable {

    public static func construct(in pipe: Pipe) -> Self {
        pipe.put(Self(delegate: pipe.put(Delegate()),
                    queue: pipe.get(),
                    options: pipe.get(for: "CBCentralManagerOptions")))
    }
    
    class Delegate: NSObject, CBCentralManagerDelegate, Pipable {
        
        func centralManagerDidUpdateState(_ central: CBCentralManager) {
            isPiped?.put(central.state)
        }
        
        func centralManager(_ central: CBCentralManager,
                            didDiscover peripheral: CBPeripheral,
                            advertisementData: [String : Any],
                            rssi RSSI: NSNumber) {
            isPiped?.put(peripheral)
            isPiped?.put((peripheral, advertisementData, RSSI))
        }
        
        func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
            isPiped?.put(peripheral, key: "didConnect")
        }
        
        func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
            isPiped?.put(error)
        }
        
        func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {

            if let error = error {
                isPiped?.put(error)
                return
            }

            isPiped?.put(peripheral, key: "didDisconnectPeripheral")
        }
        
        func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
            if let error = error {
                isPiped?.put(error)
                return
            }

            isPiped?.put(peripheral.services)
        }
        
    }
    
}
