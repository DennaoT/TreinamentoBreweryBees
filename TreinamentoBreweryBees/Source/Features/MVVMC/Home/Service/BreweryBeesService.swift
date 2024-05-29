//
//  BreweryBeesService.swift
//  TreinamentoBreweryBees
//
//  Created by Dennis Torres on 29/04/24.
//

import UIKit

// MARK: - Typealias

/// Typealias for breweries completion
typealias BreweryBeesFirestoreCompletion = (Result<BreweryListData, Error>) -> Void

/// Typealias for download image completion
typealias BreweryBeesDownloadImageCompletion = (UIImage?) -> Void

// MARK: - Protocol

/// Protocol for breweries methods
protocol BreweryBeesServiceProtocol: AnyObject {
    func fetchFirestoreBreweries(completion: @escaping BreweryBeesFirestoreCompletion)
    func fetchDownloadedImage(fromURL: String?, completion: @escaping BreweryBeesDownloadImageCompletion)
}

// MARK: - Manager

/// Singleton for operations manager
class BreweryBeesService {
    static let shared = BreweryBeesService()
    
    private weak var delegate: BreweryBeesServiceProtocol?
    
    private init() {
        self.delegate = self
    }
}

// MARK: - Operations

extension BreweryBeesService: BreweryBeesServiceProtocol {
    func fetchFirestoreBreweries(completion: @escaping BreweryBeesFirestoreCompletion) {
        FirestoreOperation.fetchFirestoreData(
            fromDocumentPath: HomeDataPath.breweryListDocumentPath
        ) { result in
            completion(result)
        }
    }
    
    func fetchDownloadedImage(fromURL: String?, completion: @escaping BreweryBeesDownloadImageCompletion) {
        ImageDownloadOperation.fetchImage(fromURL: fromURL) { image in
            completion(image)
        }
    }
}
