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

import Contacts

import Pipe
import XCTest

class Contacts_Tests: XCTestCase {
    
    func test_CNContact() {
        let e = expectation()

        |.one { (contact: CNContact) in
            e.fulfill()
        }

        waitForExpectations()
    }

    func test_CNContact_Predicate() {
        let e = expectation()

        CNContact.predicateForContacts(matchingName: "John Appleseed") | Ask.every { (contact: CNContact) in

            //Only one John Appleseed exist!
            e.fulfill()

        }

        waitForExpectations()
    }

    func test_CNContact_Predicate_Keys() {
        let e = expectation()


        let predicate = CNContact.predicateForContacts(matchingName: "John Appleseed")
        let keys: [CNKeyDescriptor] = [CNContactFamilyNameKey as NSString]

         [predicate, keys] | Ask.every { (contact: CNContact) in

            //Only one John Appleseed exist!
            if contact.familyName == "Appleseed" {
                e.fulfill()
            }
        }

        waitForExpectations()
    }

    func test_CNContactStore() {
        XCTAssertNotNil(CNContactStore.self|)
    }

}
