//
//  BeginnerHomeFactory.swift
//  TreinamentoBreweryBees
//
//  Created by Dennis Torres on 29/05/24.
//

enum BeginnerHomeFactory {
    static func make() -> BeginnerHomeViewController {
        let service: BeginnerHomeServicing = BeginnerHomeService()
        let coordinator: BeginnerHomeCoordinating = BeginnerHomeCoordinator()
        let presenter: BeginnerHomePresenting = BeginnerHomePresenter(coordinator: coordinator)
        let interactor = BeginnerHomeInteractor(service: service, presenter: presenter)
        let viewController = BeginnerHomeViewController(interactor: interactor)
        
        coordinator.viewController = viewController
        presenter.viewController = viewController

        return viewController
    }
}
