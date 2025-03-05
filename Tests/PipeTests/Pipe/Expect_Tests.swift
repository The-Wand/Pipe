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

class Expect_T_Tests: XCTestCase {

    func test_Every() throws {
        //Insert 'count' times
        let count: Int = .any(in: 1...42)

        let e = expectation()
        e.expectedFulfillmentCount = count

        var last: Vector!

        //Wait for 'count' Vectors
        weak var pipe: Pipeline!
        pipe = |.every { (vector: Vector) in
            //Is equal?
            if vector == last {
                e.fulfill()
            }
        }

        //Put for 'count' Vectors
        (0..<count).forEach { _ in
            let vector = Vector.any
            last = vector

            pipe.put(vector)
        }

        waitForExpectations(timeout: .default)

        pipe.close()
        XCTAssertNil(pipe)
    }

    func test_One() throws {
        let e = expectation()

        let vector = Vector.any

        weak var pipe: Pipeline!
        pipe = |.one { (vector: Vector) in
            e.fulfill()
        }

        pipe.put(vector)

        waitForExpectations()
        XCTAssertNil(pipe)
    }

    func test_While() throws {

        func put() {
            DispatchQueue.main.async {
                pipe.put(Vector.any)
            }
        }

        let e = expectation()

        weak var pipe: Pipeline!
        pipe = |.while { (vector: Vector) in

            if vector.id == 2 {
                e.fulfill()
                return false
            } else {
                put()
                return true
            }

        }

        put()

        waitForExpectations()
        XCTAssertNil(pipe)
    }


}


fileprivate struct Vector: Equatable, Any_ {

    let id: Int

    let x, y, z: Float
    var t: TimeInterval


    static var any: Vector {
        .init(id: .any(in: 0...4), x: .any, y: .any, z: .any, t: .any)
    }
}

extension Vector: AskingWithout {

    static func ask<T>(_ ask: Ask<T>, from pipe:Pipeline) {

        if pipe.ask(for: ask) {
            //Strong reference to pipe
            ask.cleaner = {
                print(pipe.description)
            }
        }

    }

}
