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

public protocol Pipable {

    var pipe: Pipe {get}
    var isPiped: Pipe? {get}

    var address: Int {get}

}

public extension Pipable {
    
    var pipe: Pipe {
        isPiped ?? Pipe(object: self)
    }
    
    var isPiped: Pipe? {
        Pipe[self]
    }

}

public extension Pipable where Self: AnyObject {

    var address: Int {
        Int(bitPattern: Unmanaged.passUnretained(self).toOpaque())
    }

}

public extension Pipable {

    var address: Int {
        var address: Int!
        var mutable = self
        withUnsafePointer(to: &mutable) { pointer in
            address = Int(bitPattern: pointer)
        }

        return address!
    }

}

//NO FUCKING WAY, it breaks Pipe.attach(to: array)
//extension Array: Pipable {
//
//}


struct MemoryAddress<T> {

//    let intValue: Int
//
//    var description: String {
//        let length = 2 + 2 * MemoryLayout<UnsafeRawPointer>.size
//        return String(format: "%0\(length)p", intValue)
//    }
//
//    // for structures
//    init(of structPointer: UnsafePointer<T>) {
//        intValue = Int(bitPattern: structPointer)
//    }

    static func address(of model: T) -> Int {
        var address: Int!
        var mutable = model
        withUnsafePointer(to: &mutable) { pointer in
            address = Int(bitPattern: pointer)
        }

        return address
    }
}

extension MemoryAddress where T: AnyObject {

//    // for classes
//    init(of classInstance: T) {
//        intValue = unsafeBitCast(classInstance, to: Int.self)
//        // or      Int(bitPattern: Unmanaged<T>.passUnretained(classInstance).toOpaque())
//    }


    static func address(of model: T) -> Int {
        unsafeBitCast(model, to: Int.self)
    }


}

//extension Optional {
//
//    var address: String? {
//
//        switch self {
//            case .none:
//                return nil
//
//            case .some(let some):
//                var address: String?
//                var mutable = some
//                withUnsafePointer(to: &mutable) { pointer in
//                    address = String(format: "%p", pointer)
//                }
//
//                return address
//        }
//
//    }
//
//}
//
//extension Optional where Wrapped: AnyObject {
//
//    var address: String? {
//
//        switch self {
//            case .none:
//                return nil
//
//            case .some(let object):
//                return "\(Unmanaged.passUnretained(object).toOpaque())"
//        }
//
//    }
//
//}
