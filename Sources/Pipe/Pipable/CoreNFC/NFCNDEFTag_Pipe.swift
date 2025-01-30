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

#if canImport(CoreNFC)
import CoreNFC

//AskingWithout
@discardableResult
public prefix func | (handler: @escaping (NFCNDEFTag)->() ) -> Pipe {
    nil | Ask.every(handler: handler)
}

@discardableResult
public prefix func | (ask: Ask<NFCNDEFTag>) -> Pipe {
    nil | ask
}

@discardableResult
public func | (pipe: Pipe?, ask: Ask<NFCNDEFTag>) -> Pipe {
    (pipe ?? Pipe()) as Any | ask
}

//Asking
@discardableResult
public func |<S> (scope: S, handler: @escaping (NFCNDEFTag)->() ) -> Pipe {
    scope | Ask.every(handler: handler)
}

@discardableResult
public func |<S> (scope: S, ask: Ask<NFCNDEFTag>) -> Pipe {
    let pipe = Pipe.attach(to: scope)

    guard pipe.ask(for: ask, checkScope: true) else {
        return pipe
    }

    let session: NFCNDEFReaderSession = pipe.get()
    session.alertMessage = pipe.get() ?? ""
    session.begin()

    pipe.addCleaner {
        session.invalidate()
    }

    return pipe
}

@available(iOS 13.0, *)
extension NFCNDEFTag {

    var pipe: Pipe {
        isPiped ?? Pipe(object: self)
    }

    var isPiped: Pipe? {
        Pipe[self]
    }

}

extension Ask where T == NFCNDEFTag {

    @available(iOS 13.0, *)
    public func write (_ message: NFCNDEFMessage, done: @escaping (NFCNDEFTag)->() ) -> Self {

        let oldHandler = self.handler

        self.handler = { tag in

            let pipe = tag.pipe

            let session: NFCNDEFReaderSession = pipe.get()
            
            session.connect(to: tag) { (error: Error?) in

                guard pipe.putIf(exist: error) == nil else {
                    return
                }

                pipe | .one { (status: NFCNDEFStatus) in

                    switch status {

                        case .readWrite:

                            let message = message

                            let capacity: Int = pipe.get()!
                            if message.length > capacity {

                                let e = Pipe.Error.nfc("Tag capacity is too small. Minimum size requirement is \(message.length) bytes.")
                                pipe.put(e)

                                return
                            }

                            tag.writeNDEF(message) { (error: Error?) in

                                guard pipe.putIf(exist: error) == nil else {
                                    return
                                }

                                done(tag)

                            }

                        case .readOnly:
                            let e = Pipe.Error.nfc("Tag is not writable")
                            pipe.put(e)

                        case .notSupported:
                            let e = Pipe.Error.nfc("Tag is not NDEF")
                            pipe.put(e)

                        @unknown default:
                            fatalError()

                    }

                }.inner()
                
            }

            //Call previous handler
            return oldHandler(tag)
        }

        return self
    }

    @available(iOS 13.0, *)
    public func lock (done: @escaping (NFCNDEFTag)->() ) -> Self {

        let oldHandler = self.handler

        self.handler = { tag in

            let pipe = tag.pipe

            let session: NFCNDEFReaderSession = pipe.get()

            session.connect(to: tag) { (error: Error?) in

                guard pipe.putIf(exist: error) == nil else {
                    return
                }

                tag.writeLock { error in

                    if let error = error as? NFCReaderError {

                        switch error.code {
                            case .ndefReaderSessionErrorTagUpdateFailure:

                                let e = Pipe.Error.nfc("Already locked tag 🦾\n")
                                pipe.put(e)

                            default:
                                pipe.put(error as Error)
                        }


                        return
                    }

                    done(tag)
                }

            }

            //Call previous handler
            return oldHandler(tag)
        }

        return self
    }

}

#endif
