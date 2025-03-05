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

/**Pipable

 postfix |(data: Data) -> some RestModel
 postfix |(raw: Dictionary) -> some RestModel

 infix | (url: URL, reply: (some RestModel)->() ) -> Pipe

 */

extension Data {

    public
    static postfix func |<T: Decodable>(data: Data) throws -> T {
        try JSONDecoder().decode(T.self, from: data)
    }

    static public postfix func |(raw: Self) throws -> [String: Any]? {
        try? JSONSerialization.jsonObject(with: raw, options: []) as? [String : Any]
    }

    static public postfix func |(raw: Self) throws -> [Any]? {
        try? JSONSerialization.jsonObject(with: raw, options: []) as? [Any]
    }

}

extension Dictionary {

    static public postfix func |(p: Self) -> Data {
        try! JSONSerialization.data(withJSONObject: p, options: [])
    }

    static public postfix func |<T: Rest.Model>(raw: Self) throws -> T {
        try JSONDecoder().decode(T.self, from: raw|)
    }

}

extension Array {

    static public postfix func |(p: Self) -> Data {
        try! JSONSerialization.data(withJSONObject: p, options: [])
    }

    static public postfix func |<T: Rest.Model>(raw: Self) throws -> [T] {
        try JSONDecoder().decode(T.self, from: raw|) as! [T]
    }

}

public
postfix func |<T: Decodable> (resource: Pipe.Resource) throws -> T {
    let data: Data = try Data(contentsOf: resource|)
    return try data|
}
