///
/// Copyright © 2020-2024 El Machine 🤖
/// https://el-machine.com/
///
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
///
/// 1) .LICENSE
/// 2) https://apache.org/licenses/LICENSE-2.0
///
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.
///
/// Created by Alex Kozin
/// 2020 El Machine

import CoreLocation.CLLocation

/**Pipe.Constructable

 postfix |(piped: Any?) -> CLLocationManager

 #Usage
 ```
 let pedometer: CLLocationManager = nil|
 ```

 */
extension CLLocationManager: Constructable {

    public static func construct(in pipe: Pipe) -> Self {

        let source = Self()
        source.desiredAccuracy = pipe.get(for: "CLLocationAccuracy") ??                                                     kCLLocationAccuracyThreeKilometers

        source.distanceFilter = pipe.get(for: "CLLocationDistance") ?? 100

        source.delegate = pipe.put(Delegate())

        return pipe.put(source)
    }
    
}

extension CLLocationManager {
    
    class Delegate: NSObject, CLLocationManagerDelegate, Pipable {
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if let last = locations.last {
                isPiped?.put(last)
            }

            if locations.count > 1 {
                isPiped?.put(locations)
            }
        }

        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            isPiped?.put(error)
        }

        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            isPiped?.put(status)
        }
        
    }
    
}
