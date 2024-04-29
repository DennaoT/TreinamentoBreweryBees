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
    
    // MARK: - Firebase Firestore Error
    
    case errorFirestore_unexpected
    case errorFirestore_notFound
    case errorFirestore_dataCorrupted
    case errorFirestore_notFoundDescription
    case errorFirestore_dataCorruptedDescription
    case errorFirestore_emptyDataDescription
    
    // MARK: - Home
    
    case homeNavigationTitle
    
    // MARK: - Home Results
    
    case homeResultsTitle_Success
    case homeResultsTitle_NoDataFound
    case homeResultsTitle_EmptySearch
    case homeResultsDescription_Success
    case homeResultsDescription_TryAgain
    
    // MARK: - Components
    
    case component_tryAgain
    
    // MARK: - Method
    
    var localized: String {
        NSLocalizedString(String(describing: self.self), comment: "")
    }
}
