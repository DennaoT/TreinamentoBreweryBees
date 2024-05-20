//
//  HomeModel.swift
//  TreinamentoBreweryBees
//
//  Created by Dennis Torres on 02/04/24.
//

import Foundation

// MARK: - Status

enum HomeInfoStatus<T,E> {
    case success(T)
    case error(E)
    case loading
}

// MARK: - Models

public struct BreweryListData: Decodable {
    let identifier: String
    let breweriesList: [BreweryData]
    
    enum CodingKeys: String, CodingKey {
        case identifier
        case breweriesList = "breweries"
    }
    
    public init(identifier: String? = nil, breweriesList: [BreweryData]) {
        self.identifier = generateIdentifier(from: identifier)
        self.breweriesList = breweriesList
    }
}

public struct BreweryData: Decodable {
    let identifier: String
    let name: String
    let logo: String?
    let type: String?
    let rating: String?
    let numRating: String?
    let address: String
    let website: String
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case identifier
        case name = "brewery_name"
        case logo = "brewery_logo"
        case type = "brewery_type"
        case rating = "brewery_rating"
        case numRating = "brewery_num_rating"
        case address = "brewery_address"
        case website = "brewery_website"
        case description = "brewery_description"
    }
    
    public init(
        identifier: String? = nil,
        name: String,
        logo: String? = nil,
        type: String? = nil,
        rating: String? = nil,
        numRating: String? = nil,
        address: String,
        website: String,
        description: String? = nil
    ) {
        self.identifier = generateIdentifier(from: identifier)
        self.name = name
        self.logo = logo
        self.type = type
        self.rating = rating
        self.numRating = numRating
        self.address = address
        self.website = website
        self.description = description
    }
}

private func generateIdentifier(from identifier: String?) -> String {
    guard let id = identifier, !id.removingAllWhitespaces().isEmpty else {
        return UUID().uuidString
    }
    return id
}
