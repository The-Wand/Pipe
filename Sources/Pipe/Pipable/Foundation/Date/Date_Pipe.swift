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

extension Date {

    static public postfix func |(piped: Date.Type) -> Int {
        Int(Date().timeIntervalSince1970)
    }

    static public postfix func |(piped: Date.Type) -> TimeInterval {
        Date().timeIntervalSince1970
    }

}

public postfix func |(piped: TimeInterval) -> Date {
    Date(timeIntervalSince1970: piped)
}

public postfix func |(piped: Int) -> Date {
    Date(timeIntervalSince1970: TimeInterval(piped))
}

//DateComponents
public postfix func | (piped: DateComponents) -> Date? {
    Calendar.current.date(from: piped)
}
