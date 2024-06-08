//
//  BaseCoordinatorDelegate.swift
//  TreinamentoBreweryBees
//
//  Created by Dennis Torres on 02/04/24.
//

import UIKit

public typealias Coordinator = AppCoordinating & BaseCoordinatorDelegate

public protocol AppCoordinating {
    var navigationController: UINavigationController { get set }
    func start()
}

public protocol BaseCoordinatorDelegate: AnyObject {
    func coordinatorRemoved()
}
