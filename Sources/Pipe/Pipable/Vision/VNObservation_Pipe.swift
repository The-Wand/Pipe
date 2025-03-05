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

import CoreMedia.CMSampleBuffer
import Vision.VNObservation

/// Pipe.Expectable
///
/// prefix |<E: VNObservation> (handler: (E)->() )
///
/// #Usage
/// ```
///
///   |{ (hands: [VNHumanHandPoseObservation]) in
///
///   }
///
///   URL(string: "http://example.com/image.jpg") | { (faces: [VNFaceObservation]) in
///
///   }
///
///   data | .while { (bodies: [VNHumanBodyPoseObservation]) in
///     bodies < 2
///   }
/// ```
///
public
protocol VisionObservationExpectable: Asking {

    associatedtype Request: VNRequest

}

public
extension VisionObservationExpectable {

    static func ask<T: Asking>(_ ask: Ask<T>, from pipe: Pipe) {

        guard pipe.ask(for: ask) else {
            return
        }

        let perform = { (handler: VNImageRequestHandler) in
            let request: Request = pipe.get()

            try! handler.perform([request])
            if let results = request.results, !results.isEmpty {
                pipe.put(results as! [Self])
            } else {
                pipe.close()
            }
        }

        //There is request handler already?
        if let handler: VNImageRequestHandler = pipe.get() {
            perform(handler)
        } else {
            //Otherwise wait for buffer
            pipe | { (buffer: CMSampleBuffer) in

                let request = VNImageRequestHandler(cmSampleBuffer: buffer)
                perform(request)
            }
        }
    }

}

@available(iOS 14.0, *)
extension VNFaceObservation: VisionObservationExpectable {

    public
    typealias Request = VNDetectFaceRectanglesRequest

}

@available(iOS 14.0, *)
extension VNBarcodeObservation: VisionObservationExpectable {

    public
    typealias Request = VNDetectBarcodesRequest

}

@available(iOS 14.0, macOS 11.0, *)
extension VNHumanHandPoseObservation: VisionObservationExpectable {

    public
    typealias Request = VNDetectHumanHandPoseRequest

    static func | (piped: VNHumanHandPoseObservation,
                   joint: JointName) -> CGPoint {
        let recognized = try! piped.recognizedPoint(joint)
        return CGPoint(x: recognized.location.x, y: 1 - recognized.location.y)
    }

}

@available(iOS 14.0, macOS 11.0, *)
extension VNHumanBodyPoseObservation: VisionObservationExpectable {

    public
    typealias Request = VNDetectHumanBodyPoseRequest

}

@available(iOS 14.0, *)
extension VNClassificationObservation: VisionObservationExpectable {

    public
    typealias Request = VNClassifyImageRequest

}
