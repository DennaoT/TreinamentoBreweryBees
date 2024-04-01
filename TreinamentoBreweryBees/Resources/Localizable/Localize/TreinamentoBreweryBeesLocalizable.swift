//
//  TreinamentoBreweryBeesLocalizable.swift
//  TreinamentoBreweryBees
//
//  Created by Dennis Torres on 01/04/24.
//

import Foundation

public enum TreinamentoBreweryBeesLocalizable: String {
    
    // MARK: - App Dennao
    
    case appDennao
    case userName
    case password
    
    // MARK: - Date
    
    case monthJanuary
    case monthFebruary
    case monthMarch
    case monthApril
    case monthMay
    case monthJune
    case monthJuly
    case monthAugust
    case monthSeptember
    case monthOctober
    case monthNovember
    case monthDecember
    case dateFormat
    
    // MARK: - Method
    
    var localized: String {
        NSLocalizedString(String(describing: self.self), comment: "")
    }
}
