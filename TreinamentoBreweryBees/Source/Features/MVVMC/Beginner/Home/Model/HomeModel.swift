//
//  HomeModel.swift
//  TreinamentoBreweryBees
//
//  Created by Dennis Torres on 02/04/24.
//

import UIKit

// MARK: - Status

enum HomeInfoStatus<T,E> {
    case success(T)
    case error(E)
    case loading
}

// MARK: - Models

public struct BreweryListData: Decodable {
    let identifier: String
    var breweriesList: [BreweryData]
    
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
    var logo: BreweryLogo?
    let type: String?
    var rating: BreweryRateData
    let address: String
    let website: String
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case identifier
        case name = "brewery_name"
        case logo = "brewery_logo"
        case type = "brewery_type"
        case rating = "brewery_rating"
        case address = "brewery_address"
        case website = "brewery_website"
        case description = "brewery_description"
    }
    
    public init(
        identifier: String? = nil,
        name: String,
        logo: BreweryLogo? = nil,
        type: String? = nil,
        rating: BreweryRateData,
        address: String,
        website: String,
        description: String? = nil
    ) {
        self.identifier = generateIdentifier(from: identifier)
        self.name = name
        self.logo = logo
        self.type = type
        self.rating = rating
        self.address = address
        self.website = website
        self.description = description
    }
    
    mutating func setImage(_ image: UIImage?) {
        self.logo?.image = image
    }
}

public struct BreweryLogo: Decodable {
    let url: String?
    var image: UIImage?
    
    enum CodingKeys: String, CodingKey {
        case url = "urlImage"
    }
    
    public init(url: String?, image: UIImage?) {
        self.url = url
        self.image = image
    }
}

public struct BreweryRateData: Decodable {
    let value: String
    let quantityRating: String?
    var userHasAlreadyRated: Bool
    
    enum CodingKeys: String, CodingKey {
        case value = "brewery_value_rating"
        case quantityRating = "brewery_num_rating"
        case userHasAlreadyRated
    }
    
    public init(
        value: String,
        quantityRating: String? = nil,
        userHasAlreadyRated: Bool = false
    ) {
        self.value = value
        self.quantityRating = quantityRating
        self.userHasAlreadyRated = userHasAlreadyRated
    }
}

private func generateIdentifier(from identifier: String?) -> String {
    guard let id = identifier, !id.removingAllWhitespaces().isEmpty else {
        return UUID().uuidString
    }
    return id
}
