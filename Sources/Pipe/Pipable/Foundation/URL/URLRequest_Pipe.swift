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

import Foundation

extension URLRequest: Constructable {

    public static func construct(in pipe: Pipe) -> URLRequest {

        let url: URL = pipe.get() ?? {
            let path: String = pipe.get()!
            return path|
        }()

        let method: Rest.Method     = pipe.get() ?? .GET
        let timeout: TimeInterval   = pipe.get() ?? method.timeout

        var request = URLRequest(url: url, timeoutInterval: timeout)
        request.allHTTPHeaderFields = pipe.get()
        request.httpMethod = method.rawValue
        request.httpBody = pipe.get()

        return request
    }

}
