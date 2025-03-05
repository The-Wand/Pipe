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

#if canImport(UIKit)
import UIKit

//extension UIEvent.EventSubtype: Pipable {
//
//}
//
//@available(iOS 13.0, *)
//prefix func | (motion: @escaping (UIEvent.EventSubtype)->()) {
//    //Looking for the key
//    if let key = UIWindow.key {
//        key | motion
//        return
//    }
//
//    |.one(UIWindow.didBecomeKeyNotification) { (notification: Notification) in
//        if let key = notification.object as? UIWindow {
//            key | motion
//        }
//    }
//}
//
//
//extension UIWindow: Pipable {
//
//    open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
//        guard let pipe = isPiped else {
//            return
//        }
//
//        if let event = event {
//            pipe.put(event)
//        }
//
//        pipe.put(motion)
//    }
//
//    @available(iOS 13.0, *)
//    internal static var key: UIWindow? {
//        let windowScene = UIApplication.shared.connectedScenes.first {
//            ($0 as? UIWindowScene)?.activationState == .foregroundActive
//        } as? UIWindowScene
//        return windowScene?.windows.first(where: \.isKeyWindow)
//    }
//
//}
#endif
