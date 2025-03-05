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

import Foundation.NSNotification

/**Pipable

 infix | (name: Notification.Name, handler: (Notification)->() ) -> Pipe

 #Usage
 ```
 UIApplication.didBecomeActiveNotification | { (n: Notification) in

 }
 ```

 */

extension Notification: Asking {

    public
    static func ask<T>(_ ask: Ask<T>, from pipe: Pipe) {

        let name: Notification.Name = pipe.get()!
        let key = name.rawValue

        ask.key = key

        guard pipe.ask(for: ask) else {
            return
        }

        let center: NotificationCenter = pipe.get()

        let token = center.addObserver(forName: name,
                                       object: nil,
                                       queue: nil) { notification in
            pipe.put(notification, key: key)
        }

        ask.cleaner = {
            center.removeObserver(token)
        }

    }

}
