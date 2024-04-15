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
    private var errorModel: GenericErrorView.Model?
    
    // MARK: - Public Methods
    
    init(delegate: HomeCoordinatorDelegate?) {
        self.flowDelegate = delegate
        
        documentRef = Firestore.firestore().document(HomeDataPath.breweryListDocumentPath)
    }
    
    func fetchHomeData() {
        Task {
            await fetchCurrentData()
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
            let errorModel = GenericErrorView.Model(
                titleText: "Documento não encontrado",
                descriptionText: "Não foi possivel encontrar dados do Firebase.",
                buttonText: "Tentar novamente",
                buttonAction: { [weak self] in
                    self?.fetchHomeData()
                }
            )
            breweryModel.value = .error(errorModel)
        } catch FirestoreError.emptyData {
            let errorModel = GenericErrorView.Model(
                titleText: "Documento não encontrado",
                descriptionText: "Dados do documento estão vazios ou ausentes!",
                buttonText: "Tentar novamente",
                buttonAction: { [weak self] in
                    self?.fetchHomeData()
                }
            )
            breweryModel.value = .error(errorModel)
        } catch FirestoreError.dataCorrupted {
            let errorModel = GenericErrorView.Model(
                titleText: "Dados corrompidos",
                descriptionText: "Os dados estão corrompidos durante a decodificação.",
                buttonText: "Tentar novamente",
                buttonAction: { [weak self] in
                    self?.fetchHomeData()
                }
            )
            breweryModel.value = .error(errorModel)
        } catch {
            let errorModel = GenericErrorView.Model(
                titleText: "Ocorreu um erro inesperado",
                descriptionText: "Erro: \(error.localizedDescription)",
                buttonText: "Tentar novamente",
                buttonAction: { [weak self] in
                    self?.fetchHomeData()
                }
            )
            breweryModel.value = .error(errorModel)
        }
    }
    
    private func decodeBreweryListData(from data: [String: Any]) throws -> BreweryListData {
        guard //let jsonData = try? JSONSerialization.data(withJSONObject: data),
              let breweryListData = try? Firestore.Decoder().decode(BreweryListData.self, from: data) //jsonData
        else {
            throw FirestoreError.dataCorrupted
        }
        return breweryListData
    }
}