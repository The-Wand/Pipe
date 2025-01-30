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

import AVFoundation

extension AVCaptureDevice: Constructable {

    public static func construct(in pipe: Pipe) -> Self {

        let deviceType: AVCaptureDevice.DeviceType = pipe.get()
                                                    ?? .builtInWideAngleCamera

        let mediaType: AVMediaType = pipe.get()
                                    ?? .video

        let position: AVCaptureDevice.Position = pipe.get()
                                                ?? .front

        let device = Self.default(deviceType,
                                  for: mediaType,
                                  position: position) as! Self

        return pipe.put(device)
    }

}

extension AVCaptureDeviceInput: Constructable {

    public static func construct(in pipe: Pipe) -> Self {
        let device: AVCaptureDevice = pipe.get()
        return pipe.put(try! Self(device: device))
    }

}

extension AVCaptureSession: Constructable {

    public static func construct(in pipe: Pipe) -> Self {
        pipe.put(Self())
    }

}

extension AVCaptureVideoDataOutput: Asking {

    public static func ask<T>(_ ask: Ask<T>, from pipe: Pipe) where T : Asking {

        guard pipe.ask(for: ask) else {
            return
        }

        let session: AVCaptureSession = pipe.get()
        session.beginConfiguration()

        let preset: AVCaptureSession.Preset = pipe.get() ?? .high
        session.sessionPreset = preset

        if session.inputs.isEmpty {
            let deviceInput: AVCaptureDeviceInput = pipe.get()
            session.addInput(deviceInput)
        }

        let output = Self()
        if session.canAddOutput(output) {
            session.addOutput(output)

            let discards: Bool = pipe.get(for: "alwaysDiscardsLateVideoFrames") ?? true
            output.alwaysDiscardsLateVideoFrames = discards

            let settings: [String: Any] = pipe.get()
            ?? [kCVPixelBufferPixelFormatTypeKey as String: Int(kCVPixelFormatType_420YpCbCr8BiPlanarFullRange)]
            output.videoSettings = settings

            let delegate = pipe.put(Delegate())
            let queue: DispatchQueue = pipe.get()
                                    ?? DispatchQueue(label: "Pipe_VideoDataOutput",
                                                     qos: .userInteractive)

            output.setSampleBufferDelegate(delegate, queue: queue)
        } else {
            pipe.put(Pipe.Error.vision("Could not add video data output"))
        }
        session.commitConfiguration()
        session.startRunning()

        pipe.put(output)
        ask.cleaner = {
            session.stopRunning()
        }
    }


}

extension AVCaptureVideoDataOutput {

    class Delegate: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate, Pipable {

        func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
            isPiped?.put(sampleBuffer)
        }

    }

}

extension AVCaptureVideoPreviewLayer: Constructable {

    public static func construct(in pipe: Pipe) -> Self {
        let layer = Self()
        layer.videoGravity =    pipe.get() ?? .resizeAspectFill

        layer.session =         pipe.get()

        return pipe.put(layer)
    }

}

//CoreMedia_Pipe
import CoreMedia.CMSampleBuffer

extension CMSampleBuffer: Asking {

    public static func ask<T>(_ ask: Ask<T>, from pipe: Pipe) where T : Asking {

        //AVCaptureVideoDataOutput will produce CMSampleBuffer
        pipe | Ask<AVCaptureVideoDataOutput>.every()
    }

}
