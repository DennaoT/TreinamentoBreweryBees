//
//  HomeCoordinatorDelegate.swift
//  TreinamentoBreweryBees
//
//  Created by Dennis Torres on 04/04/24.
//

import UIKit

typealias TryAgainHandler = () -> Void

protocol HomeCoordinatorDelegate: AnyObject {
    func openNextFlow(_ breweryData: BreweryData?)
    func openUrl(url urlString: String?)
    func finishFlowHome()
    func openError(tryAgainAction: @escaping TryAgainHandler)
}

extension HomeCoordinator: HomeCoordinatorDelegate {
    func openNextFlow(_ breweryData: BreweryData?) {
        //Next Coordinator
    }
    
    func openUrl(url urlString: String?) {
        guard let urlString = urlString,
              let url = URL(string: urlString),
              UIApplication.shared.canOpenURL(url) 
        else { return }
        
        UIApplication.shared.open(url)
    }
    
    func finishFlowHome() {
        //Pop current Coordinator
    }
    
    func openError(tryAgainAction: @escaping TryAgainHandler) {
        //Open Error Screen
    }
}
