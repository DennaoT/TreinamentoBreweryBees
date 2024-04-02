//
//  AppCoordinator.swift
//  TreinamentoBreweryBees
//
//  Created by Dennis Torres on 01/04/24.
//

import UIKit

class AppCoordinator: MainCoordinator {
    
    // MARK: - Properties
    
    var navigationController: UINavigationController
    
    // MARK: - Private Properties
    
    private var architecture: ArchitectureType
    
    init(navigationController: UINavigationController, architecture: ArchitectureType = .mvvmc) {
        self.navigationController = navigationController
        self.architecture = architecture
    }
    
    func start() {
        switch architecture {
        case .mvvmc:
            startMVVMC()
        case .vip:
            startVIP()
        case .viper:
            startVIPER()
        }
    }
}

extension AppCoordinator: ArchitectureConfig {
    func startMVVMC() {
        let homeCoordinator = HomeCoordinator(navigationController: navigationController)
        homeCoordinator.start()
    }
    
    func startVIP() {
        /* Intentionally unimplemented */
    }
    
    func startVIPER() {
        /* Intentionally unimplemented */
    }
}
