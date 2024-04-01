//
//  Coordinator.swift
//  TreinamentoBreweryBees
//
//  Created by Dennis Torres on 01/04/24.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}
