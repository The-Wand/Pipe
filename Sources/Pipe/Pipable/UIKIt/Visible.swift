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
import UIKit

public extension UIViewController {

    @objc fileprivate var visible: UIViewController {
        presentedViewController?.visible ?? self
    }

    var container: UIViewController? {
        tabBarController ?? navigationController ?? splitViewController
    }

    var isRoot: Bool {
        UIApplication.shared.visibleWindow?.rootViewController == self
    }

    var isVisible: Bool {
        UIApplication.shared.visibleViewController == self
    }
    
    func presentOnVisible(animated: Bool = true, completion: (() -> Void)? = nil) {
        UIApplication.shared.visibleViewController?.present(self,
                                                            animated: animated,
                                                            completion: completion)
    }

}

public extension UINavigationController {

    @objc
    override var visible: UIViewController {
        visibleViewController?.visible ?? self
    }

}

public extension UITabBarController {

    @objc
    override var visible: UIViewController {
        selectedViewController?.visible ?? self
    }

}

public extension UIApplication {

    var visibleViewController: UIViewController? {
        visibleWindow?.rootViewController?.visible
    }

    var rootViewController: UIViewController? {
        visibleWindow?.rootViewController
    }

    var visibleWindow: UIWindow? {
        if #available(iOS 13, *) {

            let scene = UIApplication.shared.connectedScenes.first {
                ($0 as? UIWindowScene)?.activationState == .foregroundActive
            } as? UIWindowScene

            return scene?.windows.first(where: \.isKeyWindow)
        } else {
            return keyWindow
        }
    }

}
#endif
