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

import Foundation


//extension DispatchTime: Asking {
//
//    static func ask<T>(with: Any?, in pipe: Pipe, expect: Event<T>) {
//
//        let after = with as! DispatchTimeInterval
//
//
//        let timer = DispatchSource.makeTimerSource()
//        timer.schedule(deadline: .now() + after, repeating: after)
//        timer.setEventHandler {
//            expecting.handle(timer)
//        }
//        timer.activate()
//
//        switch expecting.condition {
//
//            case .every, .while:
//
//                let timer = DispatchSource.makeTimerSource()
//                timer.schedule(deadline: .now() + after, repeating: after)
//                timer.setEventHandler {
////                    expecting.handle(timer)
//                }
//                timer.activate()
//
//            case .once:
//                
//
////                OperationQueue.current?.underlyingQueue
////                DispatchQueue.asyncAfter(<#T##self: DispatchQueue##DispatchQueue#>)
//        }
//    }
//
//
//}

//public extension DispatchQueue {
//
//    enum Work {
//        case async(()->() )
//        case sync(()->() )
//    }
//
//    static func |(piped: DispatchQueue, work: ()->() ) {
//        piped.sync(execute: work)
//    }
//
//}

public func | (piped: DispatchQoS.QoSClass, work: @escaping ()->() ) {
    DispatchQueue.global(qos: piped).async(execute: work)
}
//
//public func | (p: DispatchQoS.QoSClass, work: DispatchQueue.Work) {
//    let q = DispatchQueue.global(qos: p)
//    switch work {
//        case .async(let work):
//            q.async(execute: work)
//        case .sync(let work):
//            q.sync(execute: work)
//    }
//}

public func | (p: DispatchTime, work: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: p, execute: work)
}

