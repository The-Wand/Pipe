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

public protocol Asking {

    //TODO: static func |<S> (scope: S?, ask: Ask<Self>) -> Pipe
    static func ask<T: Asking>(_ ask: Ask<T>, from pipe: Pipe)

}

///   scope | { T in
///
///   }
@discardableResult
public func |<S, T: Asking> (scope: S?, handler: @escaping (T)->() ) -> Pipe {
    scope | Ask.every(handler: handler)
}


///  Ask for:
///  - `every`
///  - `one`
///  - `while`
///
///   scope | .one { T in
///
///   }
@discardableResult
public func |<S, T: Asking> (scope: S?, ask: Ask<T>) -> Pipe {
    let pipe = Pipe.attach(to: scope)
    T.ask(ask, from: pipe)

    return pipe
}
