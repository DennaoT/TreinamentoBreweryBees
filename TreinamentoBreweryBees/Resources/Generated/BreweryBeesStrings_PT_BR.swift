// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum BreweryBeesStrings_PT_BR {
  /// Localizable_PT-BR.strings
  ///   TreinamentoBreweryBees
  /// 
  ///   Created by Dennis Torres on 01/04/24.
  internal static let appDennao = BreweryBeesStrings_PT_BR.tr("Localizable_PT-BR", "appDennao", fallback: "App Dennao")
  /// %@ de %@ de %@
  internal static func dateFormat(_ p1: Any, _ p2: Any, _ p3: Any) -> String {
    return BreweryBeesStrings_PT_BR.tr("Localizable_PT-BR", "dateFormat", String(describing: p1), String(describing: p2), String(describing: p3), fallback: "%@ de %@ de %@")
  }
  /// Abril
  internal static let monthApril = BreweryBeesStrings_PT_BR.tr("Localizable_PT-BR", "monthApril", fallback: "Abril")
  /// Agosto
  internal static let monthAugust = BreweryBeesStrings_PT_BR.tr("Localizable_PT-BR", "monthAugust", fallback: "Agosto")
  /// Dezembro
  internal static let monthDecember = BreweryBeesStrings_PT_BR.tr("Localizable_PT-BR", "monthDecember", fallback: "Dezembro")
  /// Fevereiro
  internal static let monthFebruary = BreweryBeesStrings_PT_BR.tr("Localizable_PT-BR", "monthFebruary", fallback: "Fevereiro")
  /// Janeiro
  internal static let monthJanuary = BreweryBeesStrings_PT_BR.tr("Localizable_PT-BR", "monthJanuary", fallback: "Janeiro")
  /// Julho
  internal static let monthJuly = BreweryBeesStrings_PT_BR.tr("Localizable_PT-BR", "monthJuly", fallback: "Julho")
  /// Junho
  internal static let monthJune = BreweryBeesStrings_PT_BR.tr("Localizable_PT-BR", "monthJune", fallback: "Junho")
  /// Março
  internal static let monthMarch = BreweryBeesStrings_PT_BR.tr("Localizable_PT-BR", "monthMarch", fallback: "Março")
  /// Maio
  internal static let monthMay = BreweryBeesStrings_PT_BR.tr("Localizable_PT-BR", "monthMay", fallback: "Maio")
  /// Novembro
  internal static let monthNovember = BreweryBeesStrings_PT_BR.tr("Localizable_PT-BR", "monthNovember", fallback: "Novembro")
  /// Outubro
  internal static let monthOctober = BreweryBeesStrings_PT_BR.tr("Localizable_PT-BR", "monthOctober", fallback: "Outubro")
  /// Setembro
  internal static let monthSeptember = BreweryBeesStrings_PT_BR.tr("Localizable_PT-BR", "monthSeptember", fallback: "Setembro")
  /// Senha
  internal static let password = BreweryBeesStrings_PT_BR.tr("Localizable_PT-BR", "password", fallback: "Senha")
  /// Nome de usuário
  internal static let userName = BreweryBeesStrings_PT_BR.tr("Localizable_PT-BR", "userName", fallback: "Nome de usuário")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension BreweryBeesStrings_PT_BR {
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
