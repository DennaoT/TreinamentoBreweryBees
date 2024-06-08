//
//  HomeCoordinator.swift
//  TreinamentoBreweryBees
//
//  Created by Dennis Torres on 02/04/24.
//

import UIKit

class HomeCoordinator: AppCoordinating {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = HomeViewModel(delegate: self)
        let viewController = HomeViewController.instantiate(viewModel: viewModel)
        
        navigationController.pushViewController(viewController, animated: true)
    }
}
