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
import UIKit

public
protocol Rest_Model: Asking, Codable {


    static var base: String? {get}
    static var path: String {get}

    static var headers: [String : String]? {get}

}

public
extension Ask {

    class Get: Ask {
    }

    class Post: Ask {
    }

    class Put: Ask {
    }

    class Delete: Ask {
    }

}

public
extension Ask where T: Rest.Model {

    static func get(handler: @escaping (T)->() ) -> Get {
        .one(handler: handler)
    }

    static func post(handler: @escaping (T)->() ) -> Post {
        Post.one(handler: handler)
    }

    static func put(handler: @escaping (T)->() ) -> Put {
        Put.one(handler: handler)
    }

    static func delete(handler: @escaping (T)->() ) -> Delete {
        Delete.one(handler: handler)
    }

}

public
extension Ask where T == Array<Any> {

    static func get(handler: @escaping (T)->() ) -> Get {
        .one(handler: handler)
    }

}

public
extension Rest_Model {
    
    static var path: String? {
        nil
    }
    
    static var headers: [String : String]? {
        nil
    }
    
    static func ask<T>(_ ask: Ask<T>, from pipe: Pipe) where T : Asking {

        guard pipe.ask(for: ask) else {
            return
        }

        if
            let headers,
            !pipe.exist(type: [String : String].self)
        {
            pipe.store(headers)
        }
        
        pipe | .one { (data: Data) in

            do {

                if
                    let method: Rest.Method = pipe.get(),
                    method != .GET,
                    let object: Self = pipe.get()
                {
                    pipe.put(object)
                } else {

                    let D = T.self as! Decodable.Type
                    
                    let parsed = try JSONDecoder().decode(D.self, from: data)

                    pipe.put(parsed as! T)
                }
            } catch(let e) {
                pipe.put(e)
            }

            pipe.close()
        }
        
    }
    
}
