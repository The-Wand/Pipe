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

import XCTest

class MultipeerConnectivity_Tests: XCTestCase {

    weak var session: MCSession?

    func test_MCNearbyServiceAdvertiser() throws {
        let name = "MACHINE_" + UIDevice.current.name
        let peer: MCPeerID = name|


        let advertiser: MCNearbyServiceAdvertiser = peer|

        advertiser | { (invitedBy: MCPeerID) in
            let pipe = peer.pipe

            let invitation: (Bool, MCSession?) -> Void = pipe.get()!

            guard let context: Data = pipe.get(),
                  let string = context| as String?,
                  string == "🪢"
            else {
                invitation(false, nil)
                return
            }

            let session: MCSession = peer|
            session | { (data: Data) in

            }

            invitation(true, session)
        }

//        peer | { (peer: MCPeerID) in
//
//        } as Void
    }

    func sendDataToCheck(with: MCSession) {
        let gift = "💐🎁💝🧧"
        try! session?.send(gift|,
                           toPeers: with.connectedPeers,
                           with: .reliable)
    }

    func startExpectingData(from session: MCSession) {
//        session | { data in
//
//        }
    }

}
