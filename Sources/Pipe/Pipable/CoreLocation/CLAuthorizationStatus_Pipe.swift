//  Copyright © 2020-2022 El Machine 🤖
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//
//  Created by Alex Kozin
//

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

//        #if !APPCLIP
//            case .authorizedAlways:
//                source.requestAlwaysAuthorization()
//        #endif

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
