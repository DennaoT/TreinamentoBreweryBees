// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum BreweryBeesStrings_EN_US {
  /// Localizable_EN_US.strings
  ///   TreinamentoBreweryBees
  /// 
  ///   Created by Dennis Torres on 01/04/24.
  internal static let appDennao = BreweryBeesStrings_EN_US.tr("Localizable_EN_US", "appDennao", fallback: "App Dennao")
  /// %@ %@, %@
  internal static func dateFormat(_ p1: Any, _ p2: Any, _ p3: Any) -> String {
    return BreweryBeesStrings_EN_US.tr("Localizable_EN_US", "dateFormat", String(describing: p1), String(describing: p2), String(describing: p3), fallback: "%@ %@, %@")
  }
  /// Abril
  internal static let monthApril = BreweryBeesStrings_EN_US.tr("Localizable_EN_US", "monthApril", fallback: "Abril")
  /// Agosto
  internal static let monthAugust = BreweryBeesStrings_EN_US.tr("Localizable_EN_US", "monthAugust", fallback: "Agosto")
  /// Dezembro
  internal static let monthDecember = BreweryBeesStrings_EN_US.tr("Localizable_EN_US", "monthDecember", fallback: "Dezembro")
  /// Fevereiro
  internal static let monthFebruary = BreweryBeesStrings_EN_US.tr("Localizable_EN_US", "monthFebruary", fallback: "Fevereiro")
  /// Janeiro
  internal static let monthJanuary = BreweryBeesStrings_EN_US.tr("Localizable_EN_US", "monthJanuary", fallback: "Janeiro")
  /// Julho
  internal static let monthJuly = BreweryBeesStrings_EN_US.tr("Localizable_EN_US", "monthJuly", fallback: "Julho")
  /// Junho
  internal static let monthJune = BreweryBeesStrings_EN_US.tr("Localizable_EN_US", "monthJune", fallback: "Junho")
  /// Março
  internal static let monthMarch = BreweryBeesStrings_EN_US.tr("Localizable_EN_US", "monthMarch", fallback: "Março")
  /// Maio
  internal static let monthMay = BreweryBeesStrings_EN_US.tr("Localizable_EN_US", "monthMay", fallback: "Maio")
  /// Novembro
  internal static let monthNovember = BreweryBeesStrings_EN_US.tr("Localizable_EN_US", "monthNovember", fallback: "Novembro")
  /// Outubro
  internal static let monthOctober = BreweryBeesStrings_EN_US.tr("Localizable_EN_US", "monthOctober", fallback: "Outubro")
  /// Setembro
  internal static let monthSeptember = BreweryBeesStrings_EN_US.tr("Localizable_EN_US", "monthSeptember", fallback: "Setembro")
  /// Password
  internal static let password = BreweryBeesStrings_EN_US.tr("Localizable_EN_US", "password", fallback: "Password")
  /// Username
  internal static let userName = BreweryBeesStrings_EN_US.tr("Localizable_EN_US", "userName", fallback: "Username")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension BreweryBeesStrings_EN_US {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
