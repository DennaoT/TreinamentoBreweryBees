//
//  MockBreweryBeesManager.swift
//  TreinamentoBreweryBeesTests
//
//  Created by Dennis Torres on 15/05/24.
//

import Foundation
@testable import TreinamentoBreweryBees

class MockBreweryBeesManager: BreweryBeesManagerProtocol {
    var fetchResult: Result<BreweryListData, Error>?
    
    func fetchFirestoreBreweries(completion: @escaping BreweryBeesFirestoreCompletion) {
        if let result = fetchResult {
            completion(result)
        }
    }
}
