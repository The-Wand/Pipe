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

#if canImport(UIKit)
import UIKit

//IndexPath
extension Array {
    
    static public postfix func |(p: Self) -> [IndexPath] {
        (0..<p.count)|
    }
}

extension Range where Bound == Int {

    static public postfix func |(p: Self) -> [IndexPath] {
        p.map {
            IndexPath(row: $0, section: 0)
        }
    }

}

extension ClosedRange where Bound == Int {

    static public postfix func |(p: Self) -> [IndexPath] {
        p.map {
            IndexPath(row: $0, section: 0)
        }
    }

}

public postfix func |(piped: (row: Int, section: Int)) -> IndexPath {
    IndexPath(row: piped.row, section: piped.section)
}

//UIEdgeInsets
public postfix func |(piped: (top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat)) -> UIEdgeInsets {
    UIEdgeInsets(top: piped.top,
                 left: piped.left,
                 bottom: piped.bottom,
                 right: piped.right)
}

public postfix func |(piped: (CGFloat)) -> UIEdgeInsets {
    UIEdgeInsets(top: piped, left: piped, bottom: piped, right: piped)
}

public postfix func |(p: (x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat)) -> UIView {
    UIView(frame: CGRect(x: p.0, y: p.1, width: p.2, height: p.3))
}

//UITextRange

//extension UITextPosition: Pipable {
//
//}
//
//public
//postfix func |(p: UITextPosition) -> Int {
//        let field: UITextField = p.pipe.get()!
//        return field.offset(from: field.beginningOfDocument, to: p)
//}

//UIBezierPath
public postfix func |(p: CGRect) -> UIBezierPath {
    UIBezierPath(rect: p)
}

public postfix func |(p: (rect: CGRect, radius: CGFloat)) -> UIBezierPath {
    UIBezierPath(roundedRect: p.rect, cornerRadius: p.radius)
}

public postfix func |(p: (rect: CGRect, rounding: UIRectCorner, radii: CGSize)) -> UIBezierPath {
    UIBezierPath(roundedRect: p.rect, byRoundingCorners: p.rounding, cornerRadii: p.radii)
}

//UIImage
public postfix func |(p: String) -> UIImage {
    UIImage(named: p)!
}

public postfix func |(piped: String) -> UIImage? {
    UIImage(named: piped)
}

public postfix func |(p: String?) -> UIImage? {
    guard let name = p else {
        return nil
    }
    
    return UIImage(named: name)
}

#endif
