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

import Foundation.NSURLSession

extension Pipe.Error {

    static func HTTP(_ reason: String) -> Error {
        Self(reason: reason)
    }

}

extension URLSessionDataTask: Constructable {

    public static func construct(in pipe: Pipe) -> Self {

        let session: URLSession = pipe.get()
        let request: URLRequest = pipe.get()

        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                pipe.put(error)
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                pipe.put(Pipe.Error.HTTP("Not http?"))
                return
            }
            

            let statusCode = httpResponse.statusCode
            if !(200...299).contains(httpResponse.statusCode)  {
                pipe.put(Pipe.Error.HTTP("Code: \(statusCode)"))
                return
            }           

            let mime = httpResponse.mimeType
            if mime != "application/json" {
                pipe.put(Pipe.Error.HTTP("Mime: \(mime ?? "")"))
                return
            }

            guard let data = data else {
                pipe.put(Pipe.Error.HTTP("No data"))
                return
            }

            pipe.put(httpResponse)
            pipe.put(data)
        } as! Self

        return pipe.put(task)
    }

}
