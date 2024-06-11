//
//  Typealias.swift
//  TreinamentoBreweryBees
//
//  Created by Dennis Torres on 15/04/24.
//

import UIKit

// MARK: - Action Handler
public typealias ActionHandler = () -> Void

// MARK: - Text Link Handler
public typealias StringActionHandler = (_ value: String) -> Void

// MARK: - Model Handler
public typealias ModelHandler = (_ model: Decodable) -> Void

// MARK: - Image With Identifier
public typealias IdentifierImage = (identifier: String, image: UIImage)

// MARK: - Image With Identifier
public typealias IdentifierImagesHandler = ([IdentifierImage]) -> Void

// MARK: - Url Action Handler
public typealias UrlActionHandler = (_ urlString: String?, _ flow: UrlTypeFlow) -> Void
