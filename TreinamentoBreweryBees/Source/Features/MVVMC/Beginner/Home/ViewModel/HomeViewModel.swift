//
//  HomeViewModel.swift
//  TreinamentoBreweryBees
//
//  Created by Dennis Torres on 02/04/24.
//

import Foundation

// MARK: - Protocol

protocol HomeViewModelProtocol {
    var breweryModel: Dynamic<HomeInfoStatus<BreweryListData?, GenericErrorView.Model?>> { get set }
    
    func fetchHomeData()
    func updateBreweryEvaluation(id: String, newEvaluation: String)
    func updateCellsImagesIfNeeded(completion: @escaping IdentifierImagesHandler)
    func verifyEmail(email: String) -> Bool
    
    func prepareNextFlow(data: BreweryData?, completion: @escaping (HomePopupDetailsView.Model?) -> Void, showEvaluateModal: ActionHandler?)
}

class HomeViewModel: HomeViewModelProtocol {
    
    // MARK: - Internal Properties
    
    var breweryModel = Dynamic<HomeInfoStatus<BreweryListData?, GenericErrorView.Model?>>(.loading)
    
    // MARK: - Private Properties
    
    private var parentCoordinator: HomeCoordinatorDelegate?
    
    // MARK: - Public Methods
    
    init(coordinator: HomeCoordinatorDelegate?
    ) {
        self.parentCoordinator = coordinator
    }
    
    func fetchHomeData() {
        breweryModel.value = .loading
        
        BreweryBeesService.shared.fetchFirestoreBreweries { [weak self] result in
            switch result {
            case .success(let breweryData):
                self?.handleSuccess(breweryData)
            case .failure(let failure):
                self?.handleFailure(failure)
            }
        }
    }
    
    func updateBreweryEvaluation(id: String, newEvaluation: String) {
        
    }
    
    func updateCellsImagesIfNeeded(completion: @escaping IdentifierImagesHandler) {
        var imagesToUpdate: [IdentifierImage] = []
        
        breweryModel.bind { value in
            guard case .success(let breweryListData) = value,
                  let breweriesList = breweryListData?.breweriesList
            else { return }
            
            for brewery in breweriesList {
                BreweryBeesService.shared.fetchDownloadedImage(fromURL: brewery.logo?.url) { image in
                    guard let image = image else { return }
                    imagesToUpdate.append((brewery.identifier, image))
                    if brewery.identifier == breweriesList.last?.identifier {
                        completion(imagesToUpdate)
                    }
                }
            }
        }
    }
    
    func prepareNextFlow(data: BreweryData?, completion: @escaping (HomePopupDetailsView.Model?) -> Void, showEvaluateModal: ActionHandler?) {
        let detailsModel = HomePopupDetailsView.Model(breweryData: data) {
            showEvaluateModal?()
        } mapsAction: { [weak self] location in
            guard let self = self else { return }
            self.parentCoordinator?.performMaps(location: location)
        } urlAction: { [weak self] urlString, flow in
            guard let self = self else { return }
            self.parentCoordinator?.performUrl(url: urlString, flow: flow)
        }
        
        completion(detailsModel)
    }
    
    func verifyEmail(email: String) -> Bool {
        return email.contains("@") && email.contains(".")
    }
}

// MARK: - Handle Success

extension HomeViewModel {
    private func handleSuccess(_ successData: BreweryListData) {
        logData(successData)
        
        breweryModel.value = .success(successData)
    }
    
    private func logData(_ successData: BreweryListData) {
        let logger = Logger(category: "HomeViewModel")
        logger.log(message: "Success:\n\(successData)", level: .info)
    }
}

// MARK: - Handle Failures

extension HomeViewModel {
    private func handleFailure(_ failure: Error) {
        switch failure {
        case let firestoreError as FirestoreError:
            handleFirestoreError(error: firestoreError)
        case let internetError as InternetError:
            handleInternetError(error: internetError)
        default:
            handleError(title: TreinamentoBreweryBeesLocalizable.errorDefault.localized,
                        description: failure.localizedDescription)
        }
    }
    
    private func handleFirestoreError(error: FirestoreError) {
        switch error {
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
    
    private func handleInternetError(error: InternetError) {
        switch error {
        case .noConnection:
            handleError(title: TreinamentoBreweryBeesLocalizable.errorInternet_noConnection.localized,
                        description: TreinamentoBreweryBeesLocalizable.errorInternet_noConnectionDescription.localized)
        }
    }
    
    private func handleError(title: String, description: String) {
        let logger = Logger(category: "HomeViewModel")
        logger.log(message: "\(title):\n\(description)", level: .error)
        
        let errorModel = GenericErrorView.Model(
            titleText: title,
            descriptionText: description,
            buttonText: TreinamentoBreweryBeesLocalizable.errorTryAgain.localized,
            buttonAction: { [weak self] in
                self?.fetchHomeData()
            }
        )
        breweryModel.value = .error(errorModel)
    }
}
