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

public protocol AskingWithout: Asking {

}

///   |{ T in
///
///   }
@discardableResult
public prefix func |<T: Asking> (handler: @escaping (T)->() ) -> Pipe {
    nil | Ask.every(handler: handler)
}

///  Ask for:
///  - `every`
///  - `one`
///  - `while`
///
///   |.one { T in
///
///   }
@discardableResult
public prefix func |<T: Asking> (ask: Ask<T>) -> Pipe {
    nil | ask
}

///  Ask for:
///  - `every`
///  - `one`
///  - `while`
///
///   |.one { T in
///
///   }
@discardableResult
public func |<T: Asking> (pipe: Pipe?, ask: Ask<T>) -> Pipe {
    (pipe ?? Pipe()) as Any | ask
}

///  Chain
///
///  T.one | E.one
///
@discardableResult
public func |<T: AskingWithout, E: AskingWithout>(piped: Ask<T>, to: Ask<E>) -> Pipe {
    let pipe = Pipe()
    T.ask(piped, from: pipe)
    E.ask(to, from: pipe)

    return pipe
}
