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

//Description
public
postfix func |(piped: Any) -> String {
    String(describing: piped)
}


public
postfix func |<T: LosslessStringConvertible>(p: T?) -> String {
    guard let piped = p else {
        return ""
    }

    return String(piped)
}

//Data
public
postfix func |(data: Data) -> String {
    String(data: data, encoding: .utf8)!
}

public
postfix func |(data: Data) -> String? {
    String(data: data, encoding: .utf8)
}

public
postfix func |(data: Data?) -> String {
    guard let data else {
        fatalError()
    }
    return String(data: data, encoding: .utf8)!
}

public
postfix func |(data: Data?) -> String? {
    guard let data else {
        return nil
    }
    return String(data: data, encoding: .utf8)
}

extension Substring {

    public static prefix func |(sub: Substring) -> String {
        String(sub)
    }

}

public prefix func |(self: String?) -> String {
    self ?? ""
}

public func |(p: String?, filtering: CharacterSet) -> String? {
    guard let piped = p else {
        return nil
    }

    return (piped | filtering) as String
}

public func |(p: String, filtering: CharacterSet) -> String {
    String(p.unicodeScalars.filter {
        filtering.contains($0)
    })
}

public func |(p: String, replace: (bounds: Range<String.Index>, to: String)) -> String {
    var piped = p
    piped.replaceSubrange(replace.0, with: replace.1)
    return piped
}

public func |(p: String, replace: (ClosedRange<String.Index>, String)) -> String {
    var piped = p
    piped.replaceSubrange(replace.0, with: replace.1)
    return piped
}

public func |(p: String, range: NSRange) -> String {
    let from = p.index(p.startIndex, offsetBy: range.lowerBound)
    let to = p.index(p.startIndex, offsetBy: range.upperBound)

    return p | (from..<to)
}

postfix func |(piped: NSRange) -> Range<Int> {
    Range(uncheckedBounds: (piped.lowerBound, piped.upperBound))
}

public func |(p: String, range: NSRange) -> Range<String.Index> {
    let from = p.index(p.startIndex, offsetBy: range.lowerBound)
    let to = p.index(p.startIndex, offsetBy: range.upperBound)

    return (from..<to)
}

public func |(piped: String, replace: (bounds: NSRange, to: String)) -> String {
    var string = piped

    let range: Range<String.Index> = string | replace.bounds
    string.replaceSubrange(range, with: replace.to)
    return string
}

//Components
public
func |(piped: String?, separator: any StringProtocol) -> [String]? {
    piped?.components(separatedBy: separator)
}

func |(piped: String, separator: any StringProtocol) -> [String] {
    piped.components(separatedBy: separator)
}

//public func |(format: String, arguments: CVarArg...) -> String {
//
//}
