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
    private var activeTasksCount = 0
    
    private var errorModel: GenericErrorView.Model?
    
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
        guard activeTasksCount < 3 else { return }
        
        Task(priority: activeTasksCount > 1 ? .medium : .background) {
            self.activeTasksCount += 1
            do {
                await self.fetchCurrentData()
            } catch {
                self.handleError(title: "Ocorreu um erro", description: error.localizedDescription, buttonText: "Tentar novamente")
            }
            self.activeTasksCount -= 1
        }
    }
}

// MARK: - Private Methods

extension HomeViewModel {
    private func fetchCurrentData() async {
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
            handleError(title: "Documento não encontrado",
                        description: "Não foi possível encontrar dados do Firebase.",
                        buttonText: "Tentar novamente")
        } catch FirestoreError.emptyData {
            handleError(title: "Documento não encontrado",
                        description: "Dados do documento estão vazios ou ausentes!",
                        buttonText: "Tentar novamente")
        } catch FirestoreError.dataCorrupted {
            handleError(title: "Dados corrompidos",
                        description: "Os dados estão corrompidos durante a decodificação.",
                        buttonText: "Tentar novamente")
        } catch {
            handleError(title: "Ocorreu um erro inesperado",
                        description: "Erro: \(error.localizedDescription)",
                        buttonText: "Tentar novamente")
        }
    }
    
    private func decodeBreweryListData(from data: [String: Any]) throws -> BreweryListData {
        guard let breweryListData = try? Firestore.Decoder().decode(BreweryListData.self, from: data)
        else {
            throw FirestoreError.dataCorrupted
        }
        return breweryListData
    }
    
    private func handleError(title: String, description: String, buttonText: String) {
        let errorModel = GenericErrorView.Model(
            titleText: title,
            descriptionText: description,
            buttonText: buttonText,
            buttonAction: { [weak self] in
                self?.fetchHomeData()
            }
        )
        breweryModel.value = .error(errorModel)
    }
}
