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

import Pipe
import XCTest

class Codable_Array_GET_Tests: XCTestCase {

    @available(iOS 16.0, *)
    func test_any_Codable_Array() {
        let e = expectation()

        |.get { (result: [GitHubAPI.Repo]) in

            if !result.isEmpty {
                e.fulfill()
            }

        }

        waitForExpectations()
    }

    @available(iOS 16.0, *)
    func test_argument_Codable_Array() {
        let e = expectation()

        let query = "ios"
        query | .get { (result: [GitHubAPI.Repo]) in

            if !result.isEmpty {
                e.fulfill()
            }

        }

        waitForExpectations()
    }

    @available(iOS 16.0, *)
    func test_Path_Codable_Array() {
        let e = expectation()

        let path = "https://api.github.com/repositories?q=ios"
        path | .one { (array: [GitHubAPI.Repo]) in

            e.fulfill()

        }

        waitForExpectations()
    }

    @available(iOS 16.0, *)
    func test_URL_Codable_Array() {
        let e = expectation()

        let path = "https://api.github.com/repositories?q=ios"
        let url = URL(string: path)
        url | .one { (array: [GitHubAPI.Repo]) in

            e.fulfill()

        }

        waitForExpectations()
    }


}
