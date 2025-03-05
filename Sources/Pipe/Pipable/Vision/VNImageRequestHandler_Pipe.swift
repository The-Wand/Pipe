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

import CoreGraphics.CGImage
import CoreImage.CIImage

import Vision.VNRequest

//Don't waste your time
//extension VNImageRequestHandler: Constructable {
//
//    public static func construct(in pipe: Pipe) -> Self {
//
//        let orientation: CGImagePropertyOrientation = pipe.get() ?? .up
//        let options: [VNImageOption : Any] = pipe.get() ?? [:]
//
//        let request: Self
//        if let buffer: CMSampleBuffer = pipe.get() {
//            if #available(iOS 14.0, macOS 11.0, *) {
//                request = Self(cmSampleBuffer: buffer,
//                               orientation: orientation,
//                               options: options)
//            } else {
//                fatalError()
//            }
//
//            return pipe.put(request)
//        }
//
//        if let pixelBuffer: CVPixelBuffer = pipe.get() {
//            if #available(iOS 14.0, macOS 11.0, *) {
//                request = Self(cvPixelBuffer: pixelBuffer,
//                               orientation: orientation,
//                               options: options)
//            } else {
//                fatalError()
//            }
//
//            return pipe.put(request)
//        }
//
//        if let image: CGImage = pipe.get() {
//            request = Self(cgImage: image,
//                           orientation: orientation,
//                           options: options)
//
//            return pipe.put(request)
//        }
//
//
//        if let image: CIImage = pipe.get() {
//            request = Self(ciImage: image,
//                           orientation: orientation,
//                           options: options)
//
//            return pipe.put(request)
//        }
//
//
//        if let data: Data = pipe.get() {
//            request = Self(data: data,
//                           orientation: orientation,
//                           options: options)
//
//            return pipe.put(request)
//        }
//
//        if let url: URL = pipe.get() {
//            request = Self(url: url,
//                           orientation: orientation,
//                           options: options)
//
//            return pipe.put(request)
//        }
//
//
//        fatalError( """
//                    🔥 It's yet not possible to construct
//                    \(self)
//                    """)
//    }
//
//}
