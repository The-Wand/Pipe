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

import Foundation.NSTextCheckingResult

public prefix func |(piped: (NSTextCheckingResult)->() ) {
    print(
        """
            | usage

            let date: Date? = "tomorrow at 8 UTC+4" | .date

            let address: [NSTextCheckingKey: String]? = "1 InfiniteLoop in Cupertino" | .address

            let url: URL? = "1 Infiupht//www.apple.com California, United" | .link

            let phoneNumber: String? = "1 Inffornia +19323232444,States" | .phoneNumber
        """
    )
}

public func |(piped: String?, type: NSTextCheckingResult.CheckingType) -> NSOrthography? {
    switch type {
        case .date:
            return match(piped, type)?.orthography
        default:
            return nil
    }
}

public func |(piped: String?, type: NSTextCheckingResult.CheckingType) -> Date? {
    switch type {
        case .date:
            return match(piped, type)?.date
        default:
            return nil
    }

}

public func |(piped: String?, type: NSTextCheckingResult.CheckingType) -> TimeInterval? {
    switch type {
        case .date:
            return match(piped, type)?.duration
        default:
            return nil
    }
}

public func |(piped: String?, type: NSTextCheckingResult.CheckingType) -> [NSTextCheckingKey: String]? {
    switch type {
        case .address:
            return match(piped, type)?.addressComponents
        default:
            return nil
    }

}

public func |(piped: String?, type: NSTextCheckingResult.CheckingType) -> URL? {
    switch type {
        case .link:
            return match(piped, type)?.url
        default:
            return nil
    }
}

public func |(piped: String?, type: NSTextCheckingResult.CheckingType) -> String? {
    switch type {
        case .phoneNumber:
            return match(piped, type)?.phoneNumber
        default:
            return nil
    }
}

public func |(piped: String?, type: NSTextCheckingResult.CheckingType) -> TimeZone? {
    switch type {
        case .date:
            return match(piped, type)?.timeZone
        default:
            return nil
    }
}

fileprivate func match(_ piped: String?,
                       _ type: NSTextCheckingResult.CheckingType) -> NSTextCheckingResult? {
    guard let piped = piped else {
        return nil
    }

    let detector = try! NSDataDetector(types: type.rawValue)
    return detector.firstMatch(in: piped,
                               options: [],
                               range: (0, piped.count)|)
}

public func |(p: String, pattern: String) -> [NSTextCheckingResult]? {
    try? NSRegularExpression(pattern: pattern, options: [])
        .matches(in: p, options: [], range: (0, p.count)|)
}

public func |(p: String, pattern: String) -> NSTextCheckingResult? {
    (p | pattern)?.first
}
