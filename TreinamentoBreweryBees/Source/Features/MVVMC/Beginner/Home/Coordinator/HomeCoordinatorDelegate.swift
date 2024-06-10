//
//  HomeCoordinatorDelegate.swift
//  TreinamentoBreweryBees
//
//  Created by Dennis Torres on 04/04/24.
//

import UIKit

protocol HomeCoordinatorDelegate: AnyObject {
    func openNextFlow(_ breweryData: BreweryData?)
    func manageUrl(url urlString: String?, flow: UrlTypeFlow)
    func finishFlowHome()
    func openError(tryAgainAction: @escaping ActionHandler)
}

extension HomeCoordinator: HomeCoordinatorDelegate {
    func openNextFlow(_ breweryData: BreweryData?) {
        //Next Coordinator
    }
    
    func manageUrl(url urlString: String?, flow: UrlTypeFlow) {
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
    
    func finishFlowHome() {
        //Pop current Coordinator
    }
    
    func openError(tryAgainAction: @escaping ActionHandler) {
        //Open Error Screen
    }
}
