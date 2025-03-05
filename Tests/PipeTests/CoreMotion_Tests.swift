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

import CoreMotion

import Pipe
import XCTest

class CoreMotion_Tests: XCTestCase {

#if !targetEnvironment(simulator)

    func test_CMPedometerEvent() {
        let e = expectation()
        e.assertForOverFulfill = false

        |{ (event: CMPedometerEvent) in
            e.fulfill()
        }

        waitForExpectations()
    }

    //Test it while walking
//    func test_CMPedometerData() {
//        let e = expectation()
//
//        |{ (location: CMPedometerData) in
//            e.fulfill()
//        }
//
//        waitForExpectations()
//    }

#endif

    func test_CMPedometer() {
        XCTAssertNotNil(nil| as CMPedometer)
    }
}
