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

import MultipeerConnectivity.MCSession

//extension MCSession: Constructor {
//
//    static func | (piped: Any?, type: MCSession.Type) -> Self {
//        let pipe = (piped as? Pipable)?.pipe ?? Pipe()
//
//        let peer = piped as? MCPeerID ?? pipe.get()!
//        let identity = piped as? [Any] ?? pipe.get()
//        let encryption = piped as? MCEncryptionPreference ?? pipe.get()
//
//        let source = Self(peer: peer,
//                          securityIdentity: identity,
//                          encryptionPreference: encryption ?? .optional)
//        source.delegate = pipe.put(Delegate())
//        pipe.put(source)
//
//        return source
//    }
//
//    class Delegate: NSObject, MCSessionDelegate, Pipable {
//
//        func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
//            isPiped?.put(state, key: peerID.displayName + "_MCSessionState")
//        }
//
//        func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
//            isPiped?.put(peerID, key: "fromPeer")
//            isPiped?.put(peerID, key: peerID.displayName + "_Data")
//            isPiped?.put(data)
//        }
//
//        func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {}
//
//        func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {}
//
//        func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {}
//
//    }
//
//}
