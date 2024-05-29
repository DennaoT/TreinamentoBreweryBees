//
//  MockBreweryBeesService.swift
//  TreinamentoBreweryBeesTests
//
//  Created by Dennis Torres on 15/05/24.
//

import UIKit
@testable import TreinamentoBreweryBees

class MockBreweryBeesService: BreweryBeesServiceProtocol {
    var fetchResult: Result<BreweryListData, Error>?
    
    func fetchFirestoreBreweries(completion: @escaping BreweryBeesFirestoreCompletion) {
        if let result = fetchResult {
            completion(result)
        }
    }
    
    var fetchImage: UIImage?
    func fetchDownloadedImage(fromURL: String?, completion: @escaping TreinamentoBreweryBees.BreweryBeesDownloadImageCompletion) {
        if let fetchImage = fetchImage {
            completion(fetchImage)
        }
    }
}
