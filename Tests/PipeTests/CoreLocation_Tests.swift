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

import CoreLocation

class CoreLocation_Tests: XCTestCase {

    func test_CLLocation() {
        let e = expectation()
        e.assertForOverFulfill = false

        |{ (location: CLLocation) in
            e.fulfill()
        }

        waitForExpectations()
    }

    func test_CLLocation_options() {
        let e = expectation()
        e.assertForOverFulfill = false

        let accuracy = CLLocationAccuracy.any(in: [
            kCLLocationAccuracyBestForNavigation,
            kCLLocationAccuracyBest,
            kCLLocationAccuracyNearestTenMeters,
            kCLLocationAccuracyHundredMeters,
            kCLLocationAccuracyKilometer,
            kCLLocationAccuracyThreeKilometers
        ])
        let distance = ((100...420)| as Int)| as Double

        let pipe: Pipeline = ["CLLocationAccuracy": accuracy,
                              "CLLocationDistance": distance]
        let piped = pipe.scope

        pipe | { (location: CLLocation) in
            e.fulfill()
        }


        let manager: CLLocationManager = pipe.get()
        XCTAssertEqual(manager.desiredAccuracy,
                       piped["CLLocationAccuracy"] as! CLLocationAccuracy)
        XCTAssertEqual(manager.distanceFilter,
                       piped["CLLocationDistance"] as! CLLocationDistance)

        waitForExpectations()
    }

    func test_CLAuthorizationStatus() {
        let e = expectation()
        e.assertForOverFulfill = false

        |{ (status: CLAuthorizationStatus) in
            e.fulfill()
        }

        waitForExpectations()
    }

    func test_CLLocationManager() {
        XCTAssertNotNil(self| as CLLocationManager)
    }

}
