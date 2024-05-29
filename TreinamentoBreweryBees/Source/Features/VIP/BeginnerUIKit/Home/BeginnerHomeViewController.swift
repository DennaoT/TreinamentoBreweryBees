//
//  BeginnerHomeViewController.swift
//  TreinamentoBreweryBees
//
//  Created by Dennis Torres on 29/05/24.
//

import UIKit

protocol BeginnerHomeDisplaying: AnyObject {
    
}

private extension BeginnerHomeViewController.Layout {
    // example
    enum Size {
        static let imageHeight: CGFloat = 90.0
    }
}

final class BeginnerHomeViewController: UIViewController {
    enum Layout { }
    
    private let interactor: BeginnerHomeInteracting?
    
    init(interactor: BeginnerHomeInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension BeginnerHomeViewController: BeginnerHomeDisplaying {}
