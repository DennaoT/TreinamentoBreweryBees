// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum BreweryBeesStrings_FR_CA {
  /// Localizable_FR-CA.strings
  ///   TreinamentoBreweryBees
  /// 
  ///   Created by Dennis Torres on 01/04/24.
  internal static let appDennao = BreweryBeesStrings_FR_CA.tr("Localizable_FR-CA", "appDennao", fallback: "App Dennao")
  /// %@ de %@ de %@
  internal static func dateFormat(_ p1: Any, _ p2: Any, _ p3: Any) -> String {
    return BreweryBeesStrings_FR_CA.tr("Localizable_FR-CA", "dateFormat", String(describing: p1), String(describing: p2), String(describing: p3), fallback: "%@ de %@ de %@")
  }
  /// Avril
  internal static let monthApril = BreweryBeesStrings_FR_CA.tr("Localizable_FR-CA", "monthApril", fallback: "Avril")
  /// Août
  internal static let monthAugust = BreweryBeesStrings_FR_CA.tr("Localizable_FR-CA", "monthAugust", fallback: "Août")
  /// Décembre
  internal static let monthDecember = BreweryBeesStrings_FR_CA.tr("Localizable_FR-CA", "monthDecember", fallback: "Décembre")
  /// Février
  internal static let monthFebruary = BreweryBeesStrings_FR_CA.tr("Localizable_FR-CA", "monthFebruary", fallback: "Février")
  /// Janvier
  internal static let monthJanuary = BreweryBeesStrings_FR_CA.tr("Localizable_FR-CA", "monthJanuary", fallback: "Janvier")
  /// Juillet
  internal static let monthJuly = BreweryBeesStrings_FR_CA.tr("Localizable_FR-CA", "monthJuly", fallback: "Juillet")
  /// Juin
  internal static let monthJune = BreweryBeesStrings_FR_CA.tr("Localizable_FR-CA", "monthJune", fallback: "Juin")
  /// Mars
  internal static let monthMarch = BreweryBeesStrings_FR_CA.tr("Localizable_FR-CA", "monthMarch", fallback: "Mars")
  /// Mai
  internal static let monthMay = BreweryBeesStrings_FR_CA.tr("Localizable_FR-CA", "monthMay", fallback: "Mai")
  /// Novembre
  internal static let monthNovember = BreweryBeesStrings_FR_CA.tr("Localizable_FR-CA", "monthNovember", fallback: "Novembre")
  /// Octobre
  internal static let monthOctober = BreweryBeesStrings_FR_CA.tr("Localizable_FR-CA", "monthOctober", fallback: "Octobre")
  /// Septembre
  internal static let monthSeptember = BreweryBeesStrings_FR_CA.tr("Localizable_FR-CA", "monthSeptember", fallback: "Septembre")
  /// Mot de passe
  internal static let password = BreweryBeesStrings_FR_CA.tr("Localizable_FR-CA", "password", fallback: "Mot de passe")
  /// Nom d'utilisateur
  internal static let userName = BreweryBeesStrings_FR_CA.tr("Localizable_FR-CA", "userName", fallback: "Nom d'utilisateur")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension BreweryBeesStrings_FR_CA {
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
