//
//  String.swift
//  TreinamentoBreweryBees
//
//  Created by Dennis Torres on 15/04/24.
//

import Foundation

public extension String {
    static func getDateValuesFormat(_ dateFormat: String?) -> (day: String, month: String, year: String) {
        let returnDay = "\(String(describing: dateFormat?.suffix(2)))"
        let returnMonth  = "\(String(describing: dateFormat?.prefix(7).suffix(2)))"
        let returnYear = "\(String(describing: dateFormat?.prefix(4)))"
        
        return (day: returnDay, month: returnMonth, year: returnYear)
    }
    
    static func getDateWithMonthText(_ dateFormat: String?) -> String {
        let monthDate: String
        let monthNumber = dateFormat?.prefix(7).suffix(2)
        
        let returnDay = dateFormat?.suffix(2) ?? ""
        let returnYear = dateFormat?.prefix(4) ?? ""
        
        guard let monthNumber = monthNumber else { return "" }
        switch monthNumber {
        case "01":
            monthDate = TreinamentoBreweryBeesLocalizable.monthJanuary.localized
        case "02":
            monthDate = TreinamentoBreweryBeesLocalizable.monthFebruary.localized
        case "03":
            monthDate = TreinamentoBreweryBeesLocalizable.monthMarch.localized
        case "04":
            monthDate = TreinamentoBreweryBeesLocalizable.monthApril.localized
        case "05":
            monthDate = TreinamentoBreweryBeesLocalizable.monthMay.localized
        case "06":
            monthDate = TreinamentoBreweryBeesLocalizable.monthJune.localized
        case "07":
            monthDate = TreinamentoBreweryBeesLocalizable.monthJuly.localized
        case "08":
            monthDate = TreinamentoBreweryBeesLocalizable.monthAugust.localized
        case "09":
            monthDate = TreinamentoBreweryBeesLocalizable.monthSeptember.localized
        case "10":
            monthDate = TreinamentoBreweryBeesLocalizable.monthOctober.localized
        case "11":
            monthDate = TreinamentoBreweryBeesLocalizable.monthNovember.localized
        case "12":
            monthDate = TreinamentoBreweryBeesLocalizable.monthDecember.localized
        default:
            monthDate = String()
        }
        
        return String(format: TreinamentoBreweryBeesLocalizable.dateFormat.localized,
                      String(returnDay), monthDate, String(returnYear))
    }
    
    static func getFormatURL(_ fullURL: String?, removeSufix: Bool = false) -> String? {
        let prefixesToRemove = ["https://", "http://", "www/"]

        var host = fullURL
        for prefix in prefixesToRemove {
            host = host?.replacingOccurrences(of: prefix, with: "")
        }
        
        return removeSufix ? host?.components(separatedBy: "/").first : host
    }
    
    func filterString() -> String {
        let alphabet = "abcdefghijklmnopqrstuvwxyz"
        return self
            .folding(options: .diacriticInsensitive, locale: .current)
            .filter { char in
                alphabet.contains(char.lowercased())
        }
    }
    
    func filterString(charactersAllowed characters: Character...) -> String {
        var uniqueCharacters = Set<Character>(characters)
        let alphabetSet: Set<Character> = Set("abcdefghijklmnopqrstuvwxyz")
        uniqueCharacters.subtract(alphabetSet)
        return self
            .folding(options: .diacriticInsensitive, locale: .current)
            .filter { char in
                alphabetSet.contains(char.lowercased())
        }
    }
}
