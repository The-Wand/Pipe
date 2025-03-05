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

import MultipeerConnectivity

//extension MCNearbyServiceAdvertiser: Constructor {
//    
//    static func | (piped: Any?, type: MCNearbyServiceAdvertiser.Type) -> Self {
//        let pipe = piped.pipe
//
//        let peer = (piped as? MCPeerID) ?? pipe.get()
//        let service = (piped as? String) ?? pipe.get(for: "serviceType")!
//        let source = Self(peer: peer,
//                          discoveryInfo: pipe.get(),
//                          serviceType: service)
//        source.delegate = pipe.put(Delegate())
//
//        return source
//    }
//
//}
//
//extension MCNearbyServiceAdvertiser: Asking {
//
//    static func ask<E>(with: Any?, in pipe: Pipe, expect: Expect<E>) {
//        (pipe.get() as Self).startAdvertisingPeer()
//    }
//}
//
//extension MCNearbyServiceAdvertiser {
//
//    class Delegate: NSObject, MCNearbyServiceAdvertiserDelegate, Pipable {
//
//        func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
//            isPiped?.put(invitationHandler)
//            isPiped?.put(context)
//            isPiped?.put(peerID, key: MCPeerID.With.invitation.rawValue)
//        }
//
//        func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: Error) {
//            isPiped?.put(error)
//        }
//
//    }
//
//}
