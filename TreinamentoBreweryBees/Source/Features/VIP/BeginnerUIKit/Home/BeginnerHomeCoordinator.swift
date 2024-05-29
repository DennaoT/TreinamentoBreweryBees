//
//  BeginnerHomeCoordinator.swift
//  TreinamentoBreweryBees
//
//  Created by Dennis Torres on 29/05/24.
//

import UIKit

enum BeginnerHomeAction {
    case back
}

protocol BeginnerHomeCoordinating: AnyObject {
    var viewController: UIViewController? { get set }

    func perform(action: BeginnerHomeAction)
}

final class BeginnerHomeCoordinator {
    weak var viewController: UIViewController?
}

extension BeginnerHomeCoordinator: BeginnerHomeCoordinating {
    func perform(action: BeginnerHomeAction) {
        switch action {
        case .back:
            viewController?.navigationController?.popViewController(animated: true)
        }
    }
}
