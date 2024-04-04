//
//  HomeViewModel.swift
//  TreinamentoBreweryBees
//
//  Created by Dennis Torres on 02/04/24.
//

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
    
    // MARK: - Public Methods
    
    init(delegate: HomeCoordinatorDelegate?) {
        self.flowDelegate = delegate
    }
    
    func fetchHomeData() async {
        //???
    }
}

// MARK: - Private Methods

extension HomeViewModel {
    
}
