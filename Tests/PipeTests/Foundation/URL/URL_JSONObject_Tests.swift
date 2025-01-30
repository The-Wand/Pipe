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

import Pipe
import XCTest

class URL_JSONObject_Tests: XCTestCase {

    func test_Path_Array() {
        let e = expectation()

        let path = "https://api.github.com/repositories"
        path | .one { (array: [Any]) in

            if !array.isEmpty {
                e.fulfill()
            }

        }

        waitForExpectations()
    }

    @available(iOS 16.0, *)
    func test_URL_Array() {
        let e = expectation()

        let q = URLQueryItem(name: "q", value: "swift")

        var url = URL(string: "https://api.github.com/repositories")!
        url.append(queryItems: [q])

        url | .one { (array: [Any]) in

            if !array.isEmpty {
                e.fulfill()
            }

        }

        waitForExpectations()
    }

    func test_Path_Dictionary() {
        let e = expectation()

        let id = (1...100).any
        let path = "https://jsonplaceholder.typicode.com/posts/\(id)"

        path | .one { (dictionary: [String: Any]) in

            if dictionary["id"] as? Int == id {
                e.fulfill()
            }

        }

        waitForExpectations()
    }

    func test_URL_Dictionary() {
        let e = expectation()

        let id = (1...500).any
        let url = URL(string: "https://jsonplaceholder.typicode.com/comments/\(id)")!

        url | .one { (dictionary: [String: Any]) in

            if dictionary["id"] as? Int == id {
                e.fulfill()
            }

        }

        waitForExpectations()
    }

}
