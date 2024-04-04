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
    var breweryModel: Dynamic<HomeInfoStatus<BreweryListData?>> { get set }
    
    func fetchHomeData() async
}

class HomeViewModel: HomeViewModelProtocol {
    
    // MARK: - Properties
    
    var breweryModel = Dynamic<HomeInfoStatus<BreweryListData?>>(.loading)
    
    // MARK: - Private Properties
    
    private weak var flowDelegate: HomeCoordinatorDelegate?
    private var documentRef: DocumentReference?
    
    // MARK: - Public Methods
    
    init(delegate: HomeCoordinatorDelegate?) {
        self.flowDelegate = delegate
        
        documentRef = Firestore.firestore().document(HomeDataPath.breweryListDocumentPath)
    }
    
    func fetchHomeData() async {
        do {
            guard let documentSnapshot = try await documentRef?.getDocument(),
                  let data = documentSnapshot.data() 
            else {
                breweryModel.value = .error
                return
            }
            
            let breweryListData = try Firestore.Decoder().decode(BreweryListData.self, from: data)
            breweryModel.value = .success(breweryListData)
            
        } catch {
            breweryModel.value = .error
        }
    }
}
