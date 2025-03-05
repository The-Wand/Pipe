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

import ARKit.ARSession
import RealityKit

@available(iOS 13.0, *)
extension ARSession: Constructable {

    public static func construct(in pipe: Pipe) -> Self {

        //TODO: Create ARView if no?
        let arView: ARView = pipe.get()

        let session: Self = arView.session as! Self
        session.delegate = pipe.put(Delegate())

        if let configuration: ARConfiguration = pipe.get() {
            arView.automaticallyConfigureSession = false
            session.run(configuration)
        }


        return pipe.put(session)
    }

}

@available(iOS 13.0, *)
extension ARSession {

    class Delegate: NSObject, ARSessionDelegate, Pipable {

        func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {

            guard let pipe = isPiped else {
                return
            }

            let key = Ask<[ARAnchor]>.add().key!
            pipe.put(anchors, key: key)

            //Waiting for some ARAnchor
            if pipe.asking[ARAnchor.self|] != nil {

                anchors.forEach {
                    let typed = type(of: $0)| + key
                    isPiped?.put($0, key: typed)
                }

            }

        }

        func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {

            guard let pipe = isPiped else {
                return
            }

            let key = Ask<[ARAnchor]>.update().key!
            pipe.put(anchors, key: key)

            //Waiting for some ARAnchor
            if pipe.asking[ARAnchor.self|] != nil {

                anchors.forEach {
                    let key = type(of: $0)| + key
                    isPiped?.put($0, key: key)
                }

            }

        }

        func session(_ session: ARSession, didUpdate frame: ARFrame) {
            isPiped?.put(frame)
        }

        func session(_ session: ARSession, didFailWithError error: Error) {
            isPiped?.put(error)
        }

    }

}
