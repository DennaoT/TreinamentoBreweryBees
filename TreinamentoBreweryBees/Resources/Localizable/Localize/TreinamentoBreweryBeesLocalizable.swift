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
    
    // MARK: - Generic Error

    case errorDefault
    case errorTryAgain

    // MARK: - Internet Connection Error

    case errorInternet_noConnection
    case errorInternet_noConnectionDescription
    
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
    
    // MARK: - Brewery Details
    
    case breweryDetailsTitle
    case breweryDetails_EstablishmentTitle
    case breweryDetails_WebsiteTitle
    case breweryDetails_AddressTitle
    case breweryDetails_MapsTextLink
    case breweryDetails_RateButton
    case breweryDetails_RateQuantity
    case breweryDetails_RateQuantityMoreThan
    case breweryDetails_AlreadyRated
    
    // MARK: - Email
    
    case emailTextExample
    case emailInvalid
    
    // MARK: - Brewery Rating
    
    case breweryRatingTitle
    case breweryButtonTitle
    case emailExample
    case emailNotVerified
    case successTitle
    case successDescription
    case errorTitle
    case errorDescription
    
    // MARK: - Method
    
    var localized: String {
        NSLocalizedString(String(describing: self.self), comment: "")
    }
}
