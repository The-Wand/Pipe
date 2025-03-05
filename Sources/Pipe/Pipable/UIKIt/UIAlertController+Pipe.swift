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

#if canImport(UIKit)
import UIKit.UIAlertController

extension UIAlertController: Constructable {

    public static func construct(in pipe: Pipe) -> Self {

        let style: UIAlertController.Style  = pipe.get() ?? .alert
        let title: String                   = pipe.get()!

        return Self(title: title,
                    message: pipe.get(for: "UIAlertControllerMessage"),
                    preferredStyle: style)
    }

    @discardableResult
    public static func | (controller: UIAlertController,
                   action: (title: String, handler: ((UIAlertAction) -> Void)?))
    -> UIAlertController {
        controller | (action.title, .default, action.handler)
    }

    @discardableResult
    public static func | (controller: UIAlertController,
                          action: (title: String,
                                   style: UIAlertAction.Style)
    ) -> UIAlertController {
        controller | (action.title, action.style, nil)
    }

    @discardableResult
    public static func | (controller: UIAlertController,
                          title: String
    ) -> UIAlertController {
        controller | (title, nil)
    }
    
    @discardableResult
    public static func | (controller: UIAlertController,
                   action: (title: String,
                            style: UIAlertAction.Style,
                            handler: ((UIAlertAction) -> Void)?)
    ) -> UIAlertController {

        let title = NSLocalizedString(action.title, comment: "")
        controller.addAction(UIAlertAction(title: title,
                                           style: action.style,
                                           handler: action.handler))
        
        return controller
    }
    
}

#endif
