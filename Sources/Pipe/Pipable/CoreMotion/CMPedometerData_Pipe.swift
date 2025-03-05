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

import CoreMotion.CMPedometer

/**

 #Usage
 ```
 |{ (data: CMPedometerData) in

 }
 ```
 
 */
extension CMPedometerData: AskingWithout, Pipable {

    public static func ask<T>(_ ask: Ask<T>, from pipe: Pipe) where T : Asking {

        guard pipe.ask(for: ask) else {
            return
        }

        let source: CMPedometer = pipe.get()
        let date: Date          = pipe.get() ?? Date()

        source.startUpdates(from: date) { (data, error) in
            if let error = error {
                pipe.put(error)
                return
            }

            pipe.put(data!)
        }

        ask.cleaner = {
            source.stopUpdates()
        }

    }

}
