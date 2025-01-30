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

import MultipeerConnectivity.MCNearbyServiceBrowser

//extension MCNearbyServiceBrowser: Constructor {
//
//    static func |(piped: Any?, type: MCNearbyServiceBrowser.Type) -> Self {
//        let pipe = piped.pipe
//
//        let peer = piped as? MCPeerID ?? pipe.get()
//        let service: String = pipe.get(for: "serviceType")!
//
//        let source = Self(peer: peer, serviceType: service)
//        source.delegate = pipe.put(Delegate())
//        return source
//    }
//
//}
//
//extension MCNearbyServiceBrowser: Asking {
//
//        static func ask<E>(with: Any?, in pipe: Pipe, expect: Expect<E>) {
//            (pipe.get() as Self).startBrowsingForPeers()
//        }
//    }
//
//extension MCNearbyServiceBrowser {
//
//    class Delegate: NSObject, MCNearbyServiceBrowserDelegate, Pipable {
//
//        func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
//            if let info = info {
//                isPiped?.put(info)
//            }
//            isPiped?.put(peerID, key: MCPeerID.With.found.rawValue)
//        }
//
//        func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
//            isPiped?.put(peerID, key: "lostPeer")
//        }
//
//    }
//
//}
