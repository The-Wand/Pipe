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

/**

 #Usage
 ```
 |{ (permissions: CLAuthorizationStatus) in

 }

 CLAuthorizationStatus.authorizedAlways | { (permissions: CLAuthorizationStatus) in

 }

 ```

 */
extension CLAuthorizationStatus: AskingWithout, Pipable {

    public static func ask<T>(_ ask: Ask<T>, from pipe: Pipe) where T : Asking {

        guard pipe.ask(for: ask) else {
            return
        }

        let source: CLLocationManager       = pipe.get()
        let asking: CLAuthorizationStatus?  = pipe.get()

        switch asking {

        #if !APPCLIP
            case .authorizedAlways:
                source.requestAlwaysAuthorization()
        #endif

            case .none, .authorizedWhenInUse:
                source.requestWhenInUseAuthorization()

            default:
                break
        }
        
    }

}



protocol Current {

}


extension CLAuthorizationStatus: Current {


//    static func current() -> Self {
//
//        if #available(iOS 14.0, macOS 11.0, *) {
//            let manager = piped as? CLLocationManager ?? pipe.get()
//            return manager.authorizationStatus
//        } else {
//            return CLLocationManager.authorizationStatus()
//        }
//    }

//    static func current<T: CLLocationManager>(with: T) -> Self {
//
//        if #available(iOS 14.0, macOS 11.0, *) {
//            let manager = piped as? CLLocationManager ?? pipe.get()
//            return manager.authorizationStatus
//        } else {
//            return CLLocationManager.authorizationStatus()
//        }
//    }

}

//
//

public
postfix func | (manager: CLLocationManager? = nil) -> CLAuthorizationStatus {

    if #available(iOS 14.0, macOS 11.0, *) {
        let manager = manager ?? Pipe().get()
        return manager.authorizationStatus
    } else {
        return CLLocationManager.authorizationStatus()
    }

}
public
postfix func | (type: CLAuthorizationStatus.Type) -> CLAuthorizationStatus {
    nil|
}
