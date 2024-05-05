//
//  CGFloat.swift
//  TreinamentoBreweryBees
//
//  Created by Dennis Torres on 15/04/24.
//

import UIKit

public enum Measure: CGFloat {
    /// value: 4.0
    case nano = 4.0
    /// value: 8.0
    case extraSmall = 8.0
    /// value: 12.0
    case smaller = 12.0
    /// value: 16.0
    case small = 16.0
    /// value: 20.0
    case initialMedium = 20.0
    /// value: 24.0
    case medium = 24.0
    /// value: 32.0
    case big = 32.0
    /// value: 40.0
    case xBig = 40.0
    /// value: 48.0
    case large = 48.0
    /// value: 56.0
    case xLarge = 56.0
    /// value: 72.0
    case giga = 72.0
    /// value:  96.0
    case xGiga = 96.0
    /// value: zero 0.0
    case zero = 0.0
}

public extension CGFloat {
    static func measurement(_ measure: Measure) -> CGFloat {
        return measure.rawValue
    }
}

/// `TO DO
/// `let testeA: CGFloat = .fromAny("")`                           retornou     ``0
/// `let testeB: CGFloat = .fromAny("13.5")`                  retornou     ``13.5
/// `let testeC: CGFloat = .fromAny("17.3f5")`              retornou     ``17.350000381469727
/// `let testeD: CGFloat = .fromAny(3425)`                       retornou     ``3425
/// `let testeE: CGFloat = .fromAny(Float(34.123))`   retornou     ``34.123001098632813
/// `let testeF: CGFloat = .fromAny("0")`                         retornou     ``0
extension CGFloat {
    static func fromAny(_ value: Any?) -> CGFloat {
        if let doubleValue = Float(String(describing: value).adjustnumberingCorrectly()) {
            return CGFloat(doubleValue)
        } else {
            return 0
        }
    }
}
