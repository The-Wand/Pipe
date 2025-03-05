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

#if canImport(ARKit)
import ARKit

@available(iOS 13.0, *)
extension ARAnchor: Asking {

    public
    static func ask<T>(_ ask: Ask<T>, from pipe: Pipe) where T : Asking {

        guard pipe.ask(for: ask) else {
            return
        }

        let session: ARSession = pipe.get()

        ask.cleaner = {
            session.pause()
        }

    }


}

public
extension Ask {

    class Add: Ask {
    }

    class Update: Ask {
    }

    class Remove: Ask {
    }

}

@available(iOS 13.0, *)
public extension Ask where T == Array<ARAnchor> {

    static func add(_ handler: ( (T)->() )? = nil) -> Add {
        .every(key: #function, handler: handler)
    }

    static func update(_ handler: ( (T)->() )? = nil) -> Update {
        .every(key: #function, handler: handler)
    }

    static func remove(_ handler: ( (T)->() )? = nil) -> Remove {
        .every(key: #function, handler: handler)
    }

}

@available(iOS 14.3, *)
@discardableResult
public
prefix func | (ask: Ask<[ARAppClipCodeAnchor]>) -> Pipe {

    let configuration = ARWorldTrackingConfiguration()
    configuration.automaticImageScaleEstimationEnabled = true
    configuration.appClipCodeTrackingEnabled = true

    //Ask for [ARAnchor] with AR config
    return (configuration as ARConfiguration) | ask
}

#endif
