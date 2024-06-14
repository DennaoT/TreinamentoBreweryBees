//
//  HomeCoordinatorDelegate.swift
//  TreinamentoBreweryBees
//
//  Created by Dennis Torres on 04/04/24.
//

import UIKit

protocol HomeCoordinatorDelegate: AnyObject {
    func performUrl(url urlString: String?, flow: UrlTypeFlow)
    func performMaps(location: String)
    func openError(tryAgainAction: @escaping ActionHandler)
}

extension HomeCoordinator: HomeCoordinatorDelegate {
    func performUrl(url urlString: String?, flow: UrlTypeFlow) {
        guard let urlString = urlString,
              let url = URL(string: urlString),
              UIApplication.shared.canOpenURL(url) 
        else { return }
        
        switch flow {
        case .open:
            UIApplication.shared.open(url)
        case .copy:
            UIPasteboard.general.url = url
        }
    }
    
    func performMaps(location: String) {
        //Open Apple Maps with current location
        print("performMaps with location: \(location)")
    }
    
    func openError(tryAgainAction: @escaping ActionHandler) {
        //Open Error Screen
    }
}
