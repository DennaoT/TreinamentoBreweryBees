//
//  HomeError.swift
//  TreinamentoBreweryBees
//
//  Created by Dennis Torres on 15/04/24.
//

import Foundation

enum FirestoreError: Error {
    case notFound
    case emptyData
    case dataCorrupted
    case noInternet
}
