//
//  MockBreweryData.swift
//  TreinamentoBreweryBeesTests
//
//  Created by Dennis Torres on 15/05/24.
//

import Foundation

// Mock data for BreweryData
struct MockBreweryData {
    static let brewery1 = BreweryData(
        identifier: "brewery1",
        name: "Mock Brewery 1",
        logo: "https://example.com/logo1.png",
        type: "Microbrewery",
        rating: "4.5",
        numRating: "200",
        address: "123 Brewery Lane, Brewtown",
        website: "https://example.com/brewery1",
        description: "A great microbrewery with a wide selection of beers."
    )
    
    static let brewery2 = BreweryData(
        identifier: "brewery2",
        name: "Mock Brewery 2",
        logo: "https://example.com/logo2.png",
        type: "Brewpub",
        rating: "4.2",
        numRating: "150",
        address: "456 Ale Street, Hopcity",
        website: "https://example.com/brewery2",
        description: "A cozy brewpub with delicious food and beers."
    )
    
    static let brewery3 = BreweryData(
        identifier: "brewery3",
        name: "Mock Brewery 3",
        logo: "https://example.com/logo3.png",
        type: "Nanobrewery",
        rating: "4.8",
        numRating: "50",
        address: "789 Stout Avenue, Beerland",
        website: "https://example.com/brewery3",
        description: "A small nanobrewery with unique and experimental brews."
    )
    
    static let allBreweries = [brewery1, brewery2, brewery3]
}

// Mock data for BreweryListData
struct MockBreweryListData {
    static let breweryListData = BreweryListData(
        identifier: "breweryList1",
        breweriesList: MockBreweryData.allBreweries
    )
}
