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

#if canImport(CoreNFC)
import CoreNFC

extension NFCNDEFReaderSession: Constructable {

    public static func construct(in pipe: Pipe) -> Self {

        let delegate = pipe.put(Delegate())

        let source = Self(delegate: delegate,
                          queue: DispatchQueue.global(),
                          invalidateAfterFirstRead: false) //while

        let message: String = pipe.get() ?? "Hold to know what it is 🧙🏾‍♂️"
        source.alertMessage = message

        pipe.put(source)

        return pipe.put(source)
    }

}
extension NFCNDEFReaderSession {

    class Delegate: NSObject, NFCNDEFReaderSessionDelegate, Pipable {

        func readerSessionDidBecomeActive(_ session: NFCNDEFReaderSession) {
            isPiped?.put(true as Bool, key: "NFCNDEFReaderSessionIsReady")
        }

        func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
            isPiped?.put(false as Bool, key: "NFCNDEFReaderSessionIsReady")
            isPiped?.put(error)
        }

        func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        }

        @available(iOS 13.0, *)
        func readerSession(_ session: NFCNDEFReaderSession, didDetect tags: [NFCNDEFTag]) {

            if let first = tags.first {
//                isPiped?.put(first)
                
                if let pipe = isPiped {



                    let address = MemoryAddress.address(of: first)
                    print("💪🏽 set \(address)")
                    Pipe.all[address] = pipe

                    pipe.put(first)
                }
            }

//            if tags.count > 1 {
//                isPiped?.put(tags)
//            }
        }

    }

}

#endif
