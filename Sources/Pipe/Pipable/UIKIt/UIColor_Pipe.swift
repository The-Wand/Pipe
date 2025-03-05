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
import UIKit.UIImage

public postfix func |(name: String) -> UIColor {
    UIColor(named: name)!
}

//public postfix func |(hex: String) -> UIColor? {
//    hex | 1
//}

public func |(hex: String, alpha: CGFloat) -> UIColor? {
    var string = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if string.hasPrefix("#") {
        string.removeFirst()
    }
    
    guard string.count == 6 else {
        return nil
    }
    
    var rgb: UInt64 = 0
    Scanner(string: string).scanHexInt64(&rgb)
    
    return UIColor(red:     CGFloat((rgb & 0xFF0000) >> 16  ) / 255.0,
                   green:   CGFloat((rgb & 0x00FF00) >> 8   ) / 255.0,
                   blue:    CGFloat((rgb & 0x0000FF)        ) / 255.0,
                   alpha:   alpha)
}

public func |(color: UIColor, alpha: CGFloat) -> UIColor {
    color.withAlphaComponent(alpha)
}

public postfix func |(piped: (white: CGFloat, alpha:CGFloat)) -> UIColor {
    UIColor(white: piped.white, alpha: piped.alpha)
}

public postfix func |<T: FixedWidthInteger>(color: T) -> UIColor {
    color | 1
}

public func |<T: FixedWidthInteger>(color: T, alpha: CGFloat) -> UIColor {
    UIColor(red:  CGFloat((color & 0xFF0000) >> 16) / 255.0,
            green:  CGFloat((color & 0x00FF00) >> 8) / 255.0,
            blue:  CGFloat((color & 0x0000FF)) / 255.0,
            alpha: alpha)
}

#endif
