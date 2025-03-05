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

import Foundation

extension Bool {

    static public postfix func |<T: Numeric> (p: Self) -> T {
        p ? 1 : 0
    }

}

extension BinaryInteger {

    static public postfix func |(piped: Self) -> Double {
        Double(piped)
    }

    static public postfix func |(piped: Self) -> CGFloat {
        CGFloat(piped)
    }

}

extension Double {
    
    static public postfix func |(p: Self) -> Float {
        Float(p)
    }
    
}

extension String {
    
    static public postfix func |(self: Self) -> Int? {
        Int(self) ?? Int(String(self.unicodeScalars.filter(CharacterSet.decimalDigits.inverted.contains)))
    }
    
    static public postfix func |(self: Self) -> Int {
        (self|)!
    }
    
}

extension BinaryFloatingPoint {

    public static postfix func |(p: Self) -> Int {
        Int(p)
    }

}

public postfix func |(piped: String?) -> Double? {
    Double(piped ?? "")
}
