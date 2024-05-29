//
//  BeginnerHomeInteractor.swift
//  TreinamentoBreweryBees
//
//  Created by Dennis Torres on 29/05/24.
//

import Foundation

protocol BeginnerHomeInteracting: AnyObject {}

final class BeginnerHomeInteractor {
    private let service: BeginnerHomeServicing
    private let presenter: BeginnerHomePresenting

    init(service: BeginnerHomeServicing, presenter: BeginnerHomePresenting) {
        self.service = service
        self.presenter = presenter
    }
}

extension BeginnerHomeInteractor: BeginnerHomeInteracting {}
