//
//  HomeViewModel.swift
//  TreinamentoBreweryBees
//
//  Created by Dennis Torres on 02/04/24.
//

import UIKit

// MARK: - Protocol

protocol HomeViewModelProtocol {
    var breweryModel: Dynamic<HomeInfoStatus<BreweryListData?, GenericErrorView.Model?>> { get set }
    
    func fetchHomeData()
}

class HomeViewModel: HomeViewModelProtocol {
    
    // MARK: - Internal Properties
    
    var breweryModel = Dynamic<HomeInfoStatus<BreweryListData?, GenericErrorView.Model?>>(.loading)
    
    // MARK: - Private Properties
    
    private weak var flowDelegate: HomeCoordinatorDelegate?
    
    // MARK: - Public Methods
    
    init(delegate: HomeCoordinatorDelegate?
    ) {
        self.flowDelegate = delegate
    }
    
    /// TODO
    /// - usar -> semaphore: criar uma fila de concorrencia
    /// - limitar o numero de threads
    /// - semaforo await q espera o proximo slot disponivel
    func fetchHomeData() {
        breweryModel.value = .loading
        
        BreweryBeesManager.shared?.fetchFirestoreBreweries { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let breweryData):
                    self.breweryModel.value = .success(breweryData)
                case .failure(let failure):
                    self.handleFailure(failure)
                }
            }
        }
    }
}

// MARK: - Handle Failures

extension HomeViewModel {
    private func handleFailure(_ failure: FirestoreError) {
        switch failure {
        case .notFound:
            handleError(title: TreinamentoBreweryBeesLocalizable.errorFirestore_notFound.localized,
                        description: TreinamentoBreweryBeesLocalizable.errorFirestore_notFoundDescription.localized)
        case .emptyData:
            handleError(title: TreinamentoBreweryBeesLocalizable.errorFirestore_notFound.localized,
                        description: TreinamentoBreweryBeesLocalizable.errorFirestore_emptyDataDescription.localized)
        case .dataCorrupted:
            handleError(title: TreinamentoBreweryBeesLocalizable.errorFirestore_dataCorrupted.localized,
                        description: TreinamentoBreweryBeesLocalizable.errorFirestore_dataCorruptedDescription.localized)
        }
    }
    
    private func handleError(title: String, description: String) {
        let errorModel = GenericErrorView.Model(
            titleText: title,
            descriptionText: description,
            buttonText: TreinamentoBreweryBeesLocalizable.component_tryAgain.localized,
            buttonAction: { [weak self] in
                self?.fetchHomeData()
            }
        )
        breweryModel.value = .error(errorModel)
    }
}
