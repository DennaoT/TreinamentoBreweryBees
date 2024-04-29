//
//  HomeViewModel.swift
//  TreinamentoBreweryBees
//
//  Created by Dennis Torres on 02/04/24.
//

import FirebaseCore
import FirebaseFirestore
import UIKit

// MARK: - Protocol

protocol HomeViewModelProtocol {
    var breweryModel: Dynamic<HomeInfoStatus<BreweryListData?, GenericErrorView.Model?>> { get set }
    
    func fetchHomeData()
}

class HomeViewModel: HomeViewModelProtocol {
    
    // MARK: - Properties
    
    var breweryModel = Dynamic<HomeInfoStatus<BreweryListData?, GenericErrorView.Model?>>(.loading)
    
    // MARK: - Private Properties
    
    private weak var flowDelegate: HomeCoordinatorDelegate?
    private var documentRef: DocumentReference?
    
    // MARK: - Public Methods
    
    init(delegate: HomeCoordinatorDelegate?) {
        self.flowDelegate = delegate
        
        documentRef = Firestore.firestore().document(HomeDataPath.breweryListDocumentPath)
    }
    
    /// TODO
    /// - usar -> semaphore: criar uma fila de concorrencia
    /// - limitar o numero de threads
    /// - semaforo await q espera o proximo slot disponivel
    func fetchHomeData() {
        breweryModel.value = .loading
        
        Task {
            do {
                try await fetchCurrentData()
            } catch {
                handleError(title: TreinamentoBreweryBeesLocalizable.errorFirestore_unexpected.localized,
                            description: error.localizedDescription)
            }
        }
    }
}

// MARK: - Private Methods

extension HomeViewModel {
    private func fetchCurrentData() async throws {
        do {
            guard let documentSnapshot = try await documentRef?.getDocument() else {
                throw FirestoreError.notFound
            }
            
            guard let data = documentSnapshot.data() else {
                throw FirestoreError.emptyData
            }
            
            let breweryListData = try decodeBreweryListData(from: data)
            breweryModel.value = .success(breweryListData)
            
        } catch FirestoreError.notFound {
            handleError(title: TreinamentoBreweryBeesLocalizable.errorFirestore_notFound.localized,
                        description: TreinamentoBreweryBeesLocalizable.errorFirestore_notFoundDescription.localized)
        } catch FirestoreError.emptyData {
            handleError(title: TreinamentoBreweryBeesLocalizable.errorFirestore_notFound.localized,
                        description: TreinamentoBreweryBeesLocalizable.errorFirestore_emptyDataDescription.localized)
        } catch FirestoreError.dataCorrupted {
            handleError(title: TreinamentoBreweryBeesLocalizable.errorFirestore_dataCorrupted.localized,
                        description: TreinamentoBreweryBeesLocalizable.errorFirestore_dataCorruptedDescription.localized)
        } catch {
            handleError(title: TreinamentoBreweryBeesLocalizable.errorFirestore_unexpected.localized,
                        description: error.localizedDescription)
        }
    }
    
    private func decodeBreweryListData(from data: [String: Any]) throws -> BreweryListData {
        guard let breweryListData = try? Firestore.Decoder().decode(BreweryListData.self, from: data)
        else {
            throw FirestoreError.dataCorrupted
        }
        return breweryListData
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
