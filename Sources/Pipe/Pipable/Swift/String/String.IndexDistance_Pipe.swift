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

//Substring
public func |(p: String, range: PartialRangeThrough<Int>) -> String {
    String(p.suffix(range.upperBound))
}

public func |(p: String, range: PartialRangeFrom<Int>) -> String {
    String(p.prefix(range.lowerBound))
}

public func |(p: String, range: Range<Int>) -> String {
    let from = p.index(p.startIndex, offsetBy: range.lowerBound)
    let to = p.index(p.startIndex, offsetBy: range.upperBound)

    return p | (from..<to)
}

public func |(p: String, range: Range<String.Index>) -> String {
    String(p[range])
}

//Replace
public func |(p: String, replace: (bounds: Range<Int>, to: String)) -> String {
    let from = p.index(p.startIndex, offsetBy: replace.bounds.lowerBound)
    let to = p.index(p.startIndex, offsetBy:  replace.bounds.upperBound)

    return p | (bounds: from..<to, to: replace.to)
}

public func |(piped: String?, range: PartialRangeFrom<Int>?) -> (String, String)? {
    piped == nil || range == nil ? nil
    : piped! | range!
}

public func |(piped: String, range: PartialRangeFrom<Int>) -> (String, String) {
    (String(piped.prefix(range.lowerBound)), String(piped.suffix(piped.count - range.lowerBound)))
}
