//
//  AppCoordinator.swift
//  TreinamentoBreweryBees
//
//  Created by Dennis Torres on 01/04/24.
//

import UIKit

enum ArchitectureType {
    case mvvmc_uikit, mvvmc_weakref_uikit, vip_uikit, vip_swiftui_combine, viper
}

class AppCoordinator: MainCoordinator {
    
    // MARK: - Properties
    
    var navigationController: UINavigationController
    
    // MARK: - Private Properties
    
    private var architecture: ArchitectureType
    
    init(navigationController: UINavigationController, architecture: ArchitectureType = .mvvmc_uikit) {
        self.navigationController = navigationController
        self.architecture = architecture
    }
    
    func start() {
        switch architecture {
        case .mvvmc_uikit:
            start_MVVMC_UIKit()
        case .mvvmc_weakref_uikit:
            start_MVVMC_WeakReference_UIKit()
        case .vip_uikit:
            start_VIP_UIKit()
        case .vip_swiftui_combine:
            start_VIP_SwiftUI_Combine()
        case .viper:
            start_VIPER()
        }
    }
}

extension AppCoordinator {
    private func start_MVVMC_UIKit() {
        let homeCoordinator = HomeCoordinator(navigationController: navigationController)
        homeCoordinator.start()
    }
    
    private func start_MVVMC_WeakReference_UIKit() {
        /* Intentionally unimplemented */
    }
    
    private func start_VIP_UIKit() {
        /* Intentionally unimplemented */
    }
    
    private func start_VIP_SwiftUI_Combine() {
        /* Intentionally unimplemented */
    }
    
    private func start_VIPER() {
        /* Intentionally unimplemented */
    }
}
