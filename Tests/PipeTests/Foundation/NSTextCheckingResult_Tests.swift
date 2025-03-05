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

import Foundation.NSTextCheckingResult

import Pipe
import XCTest

class NSTextCheckingResultCheckingType_Tests: XCTestCase {

//    func test_NSTextCheckingResult_orthography() {
//        let found: NSOrthography? = ",tomrrow at 8 UTC+4" | .orthography
//
//        //Check equality
//        let calculated = NSOrthography()
//
//        XCTAssertEqual(found, calculated)
//    }
//
//    func test_NSTextCheckingResult_spelling() {
//        let found: NSOrthography? = ",tomrrow at 8 UTC+4" | .spelling
//
//        //Check equality
//        let calculated = NSOrthography()
//        XCTAssertEqual(found, calculated)
//    }
//
//    func test_NSTextCheckingResult_grammar() {
//        let found: NSOrthography? = ",tomrrow at 8 UTC+4" | .grammar
//
//        //Check equality
//        let calculated = NSOrthography()
//        XCTAssertEqual(found, calculated)
//    }

//    @available(iOS 15, *)
//    func test_NSTextCheckingResult_date() {
//        let hour = Int.any(in: 0...24)
//
//        let found: Date? = "tomorrow at \(hour) UTC+4" | .date
//
//        //Check equality
//        let calendar = Calendar.current
//        var components = calendar.dateComponents([.day, .month, .year, .hour], from: .now)
//        components.day = components.day! + 1
//        components.hour = hour
//        components.timeZone = TimeZone(identifier: "UTC+4")
//
//        let calculated = Calendar.current.date(from: components)
//
//        XCTAssertEqual(found, calculated)
//    }
//
    func test_NSTextCheckingResult_address() {
        let found: [NSTextCheckingKey: String]? = "1 Infinite Loop in Cupertino, California, United States" | .address

        //Check equality
        let calculated = [NSTextCheckingKey.state: "California",
                          NSTextCheckingKey.city: "Cupertino",
                          NSTextCheckingKey.street: "1 Infinite Loop",
                          NSTextCheckingKey.country: "United States"]
        XCTAssertEqual(found, calculated)
    }

    func test_NSTextCheckingResult_url() {
        let found: URL? = "1 Infinite Loop in Cupht//www.apple.com California, United States" | .link

        //Check equality
        let calculated = URL(string: "http://www.apple.com")
        XCTAssertEqual(found, calculated)
    }

    func test_NSTextCheckingResult_phoneNumber() {
        let found: String? = "1 Inffornia +19323232444,United States" | .phoneNumber

        //Check equality
        let calculated = "+19323232444"
        XCTAssertEqual(found, calculated)
    }

}
