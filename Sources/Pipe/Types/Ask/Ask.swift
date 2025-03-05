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

protocol AskFor {

    var isInner: Bool {get}

}

public
class Ask<T>: AskFor {

    public
    enum Condition {

        case every, one, `while`

    }

    let condition: Condition

    var key: String?

    public
    var handler: (T)->(Bool)

    public
    var cleaner: ( ()->() )?

    //Inner is not asked by user
    public private(set)
    var isInner: Bool = false

    public
    func inner() -> Self {
        isInner = true
        return self
    }

    internal required
    init(_ condition: Condition,
         key: String? = nil,
         handler: @escaping (T) -> Bool) {

        self.condition = condition
        self.key = key
        self.handler = handler
    }

    public
    static func every(_ type: T.Type? = nil,
                      key: String? = nil,
                      handler: ( (T)->() )? = nil ) -> Self {
        Self(.every, key: key) {
            handler?($0)

            //Retry?
            return true
        }
    }

    public
    static func one(_ type: T.Type? = nil,
                    handler: ( (T)->() )? = nil ) -> Self {
        Self(.one) {
            handler?($0)

            //Retry?
            return false
        }
    }

    public
    static func `while`(_ type: T.Type? = nil,
                        handler: @escaping (T)->(Bool) ) -> Self {
        //Decide to retry in handler
        Self(.while, handler: handler)
    }

}

extension Ask {

    //While counting
    public
    static func `while`(_ handler: @escaping (T, Int)->(Bool) ) -> Self {
        var i = 0
        return Self(.while) {
            defer {
                i += 1
            }

            return handler($0, i)
        }
    }

}
