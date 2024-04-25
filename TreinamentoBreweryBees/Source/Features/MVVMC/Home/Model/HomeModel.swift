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

struct BreweryListData: Decodable {
    let identifier: String
    let breweriesList: [BreweryData]
    
    enum CodingKeys: String, CodingKey {
        case identifier
        case breweriesList = "breweries"
    }
}

struct BreweryData: Decodable {
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
}
