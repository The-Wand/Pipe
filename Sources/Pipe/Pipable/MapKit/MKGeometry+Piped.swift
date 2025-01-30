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

import MapKit

public protocol Num {

    var double: Double {get}
    var int: Int {get}

}

public extension Num where Self: BinaryFloatingPoint {

    var double: Double {
        Double(self)
    }

    var int: Int {
        Int(self)
    }

}

public extension Num where Self: BinaryInteger {

    var double: Double {
        Double(self)
    }

    var int: Int {
        Int(self)
    }

}

extension Double: Num {
}

extension CGFloat: Num {
}

extension Float: Num {
}

extension Int: Num {
}

//extension MKMapPoint {

public postfix func |(piped: CLLocationCoordinate2D) -> MKMapPoint {
    MKMapPoint(piped)
}

public postfix func |(piped: CLLocation) -> MKMapPoint {
    MKMapPoint(piped.coordinate)
}

//public postfix func |<T: BinaryFloatingPoint, U: BinaryFloatingPoint>(piped: (x: T, y: U)) -> MKMapPoint {
//    MKMapPoint(x: Double(piped.x), y: Double(piped.y))
//}

public postfix func |<T: Num, U: Num>(piped: (x: T, y: U)) -> MKMapPoint {
    MKMapPoint(x: piped.x.double, y: piped.x.double)
}

//}

//extension MKMapSize {

public postfix func |(piped: Double) -> MKMapSize {
    MKMapSize(width: piped, height: piped)
}

//}

//extension MKMapRect {

public func |(piped: MKMapPoint, size: MKMapSize) -> MKMapRect {
    MKMapRect(origin: piped, size: size).offsetBy(dx: -size.width / 2,
                                                  dy: -size.height / 2)
}

public func |(piped: MKMapPoint, side: Double) -> MKMapRect {
    MKMapRect(origin: piped, size: side|).offsetBy(dx: -side / 2, dy: -side / 2)
}

//}
