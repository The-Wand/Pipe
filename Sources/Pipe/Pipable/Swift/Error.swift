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

import Foundation
import CloudKit

/**
 Add error handler
 - Parameters:
 - handler: Will be invoked only after error
 */
@discardableResult
public func | (piped: Pipable, handler: @escaping (Error)->() ) -> Pipe {
    let pipe = piped.pipe
    _ = pipe.ask(for: .every(Error.self, handler: handler).inner())

    return pipe
}

/**
 Add success and error handler
 - Parameters:
 - handler: Will be invoked after success and error
 */
//@discardableResult
//public func | (piped: Pipable, handler: @escaping (Error?)->() ) -> Pipe {
//    //TODO: Rewrite "Error" expectations
//    let pipe = piped.pipe
//
//    _ = pipe.expect(.every(handler).inner())
//
//    //    pipe.expectations["Error"] = [
//    //        Expect.every(handler)
//    //    ]
//
//    return pipe
//}

extension Pipe {

    struct Error: Swift.Error {

        let code: Int
        let reason: String

        init(code: Int = .zero, reason: String, function: String = #function) {
            self.code = code
            self.reason = function + reason
        }

        static func vision(_ reason: String) -> Error {
            Self(reason: reason)
        }

    }

}
