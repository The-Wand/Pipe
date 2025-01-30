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

import CoreBluetooth.CBManager

/// Ask for object
///
/// |{ (state: CBManagerState) in
///
/// }
@discardableResult
prefix func |(handler: @escaping (CBManagerState)->()) -> Pipe {
    Pipe() | Ask.every(handler: handler)
}

/// Ask for object
/// `every`, `one` or `while`
///
/// |.every { (state: CBManagerState) in
///
/// }
@discardableResult
prefix func |(ask: Ask<CBManagerState>) -> Pipe {
    Pipe() | ask
}

/// Ask for object from `context`
///
/// context | { (state: CBManagerState) in
///
/// }
@discardableResult
func |<T> (context: T, handler: @escaping (CBManagerState)->()) -> Pipe {
    context | Ask.every(handler: handler)
}

/// Ask for object from `context`
/// `every`, `one` or `while`
///
/// context | .every { (state: CBManagerState) in
///
/// }
@discardableResult
func |<T> (context: T, ask: Ask<CBManagerState>) -> Pipe {

    let pipe = Pipe.attach(to: context)

    guard pipe.ask(for: ask) else {
        return pipe
    }

    //Just construct Manager
    let _: CBCentralManager = pipe.get()
    return pipe
    
}
