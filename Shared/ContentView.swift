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

import CoreBluetooth
import CoreLocation

import SwiftUI
import Pipe

struct ContentView: View {

    var body: some View {
        Text("Hello, Pipe |").onAppear {



//            |
//                .retrieve { (peripherals: [CBPeripheral]) in
//                    print()
//                }

            let uids: [CBUUID] = [.flipperZerof6,
                                  .flipperZeroWhite,
                                  .flipperZeroBlack]

            let pipe = Pipeline()
            pipe.store(uids)

            pipe | { (peripheral: CBPeripheral) in
                print(peripheral.name)
            }


        }

    }

    func codes() {

    }

}

struct ContentView_Previews: PreviewProvider {

    static var previews: some View {
        ContentView()
    }

}
