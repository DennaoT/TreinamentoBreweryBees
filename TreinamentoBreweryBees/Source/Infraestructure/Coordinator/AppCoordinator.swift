//
//  AppCoordinator.swift
//  TreinamentoBreweryBees
//
//  Created by Dennis Torres on 01/04/24.
//

import UIKit

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    ///Verifica se já esta logado no celular
    var isLoggedIn: Bool = true
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        isLoggedIn ? showHome() : showLogin()
    }
    
    private func showLogin() {
        let vc = ViewController()
        navigationController.pushViewController(vc, animated: true)
    }
    
    private func showHome() {
        let vc = ViewController()
        navigationController.pushViewController(vc, animated: true)
    }
}
