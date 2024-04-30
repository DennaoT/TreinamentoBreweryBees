//
//  BreweryBeesManager.swift
//  TreinamentoBreweryBees
//
//  Created by Dennis Torres on 29/04/24.
//

import Foundation

// MARK: - Typealias

/// Typealias for breweries completion
typealias BreweryBeesFirestoreCompletion = (Result<BreweryListData, Error>) -> Void

// MARK: - Protocol

/// Protocol for breweries methods
protocol BreweryBeesManagerProtocol: AnyObject {
    func fetchFirestoreBreweries(completion: @escaping BreweryBeesFirestoreCompletion)
}

// MARK: - Manager

/// Singleton for operations manager
class BreweryBeesManager {
    static let shared = {
        BreweryBeesManager().delegate
    }()
    
    private weak var delegate: BreweryBeesManagerProtocol?
    
    private init() {
        self.delegate = self
    }
}

// MARK: - Operations

extension BreweryBeesManager: BreweryBeesManagerProtocol {
    func fetchFirestoreBreweries(completion: @escaping BreweryBeesFirestoreCompletion) {
        FirestoreOperation.fetchFirestoreData(
            fromDocumentPath: HomeDataPath.breweryListDocumentPath
        ) { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}
