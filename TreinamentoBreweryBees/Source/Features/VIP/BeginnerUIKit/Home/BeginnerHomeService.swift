//
//  BeginnerHomeService.swift
//  TreinamentoBreweryBees
//
//  Created by Dennis Torres on 29/05/24.
//

import Foundation

protocol BeginnerHomeServicing {
    func fetchFirestoreBreweries(completion: @escaping BreweryBeesFirestoreCompletion)
    func fetchDownloadedImage(fromURL: String?, completion: @escaping BreweryBeesDownloadImageCompletion)
}

final class BeginnerHomeService {}

extension BeginnerHomeService: BeginnerHomeServicing {
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
