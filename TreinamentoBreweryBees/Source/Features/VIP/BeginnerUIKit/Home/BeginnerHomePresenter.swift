//
//  BeginnerHomePresenter.swift
//  TreinamentoBreweryBees
//
//  Created by Dennis Torres on 29/05/24.
//

import Foundation

protocol BeginnerHomePresenting: AnyObject {
    var viewController: BeginnerHomeDisplaying? { get set }
}

final class BeginnerHomePresenter {
    weak var viewController: BeginnerHomeDisplaying?
    private let coordinator: BeginnerHomeCoordinating

    init(coordinator: BeginnerHomeCoordinating) {
        self.coordinator = coordinator
    }
}

extension BeginnerHomePresenter: BeginnerHomePresenting {}
