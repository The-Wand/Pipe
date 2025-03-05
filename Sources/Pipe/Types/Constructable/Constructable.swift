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

import Foundation

/// Create object with default settings
/// Use options to customize.
public protocol Constructable: Pipable {

    static func construct(in pipe: Pipe) -> Self

}

/// Construct on type
public postfix func |<T: Constructable>(type: T.Type) -> T {
    T.construct(in: Pipe())
}

/// Construct
public postfix func |<T: Constructable>(pipe: Pipe?) -> T {
    if let pipe {
        return pipe.get() ?? T.construct(in: pipe)
    }

    return T.construct(in: Pipe())
}

/// Construct with settings
public postfix func |<P, T: Constructable>(settings: P) -> T {
    let pipe = Pipe.attach(to: settings)
    return pipe.get() ?? T.construct(in: pipe)
}

public extension Pipe {

    /// Create Constructable if need
    /// - Parameter key: Stroring key
    /// - Returns: T
    func get<T: Constructable>(for key: String? = nil) -> T {
        let get: T? = get(for: key)
        return get ?? self|
    }
    
}
