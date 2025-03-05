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

import CoreLocation
import CoreMotion

import Pipe
import XCTest

class Expect_Any_Tests: XCTestCase {

#if !targetEnvironment(simulator)

    func test_Any() throws {
        let e = expectation(description: "event.any")
        e.assertForOverFulfill = false

        CLLocation.every | CMPedometerEvent.every | .any {
            print("Every " + $0|)
            e.fulfill()
        }

        waitForExpectations()
    }

    func test_All() throws {
        let e = expectation(description: "event.any")
        e.expectedFulfillmentCount = 2

        var pipe: Pipeline!
        pipe = (CLLocation.one | CMPedometerEvent.one | .all { _ in

            if let piped: CLLocation = pipe.get() {
                e.fulfill()
            }

            if let piped: CMPedometerEvent = pipe.get() {
                e.fulfill()
            }

        })

        waitForExpectations()
    }

#endif

}
