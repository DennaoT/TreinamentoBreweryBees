//
//  BeginnerResultView.swift
//  TreinamentoBreweryBees
//
//  Created by Dennis Torres on 31/05/24.
//

import UIKit

protocol BeginnerResultDisplaying: AnyObject {
    func display()
}

final class BeginnerResultView: UIView {
    
    // MARK: - Enums
    
    private enum Constants {
        static let mainViewColor: UIColor = .white
        static let defaultSpacing: CGFloat = .measurement(.small)
    }
    
    // MARK: - Views
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = Constants.defaultSpacing
        return stackView
    }()
    
    // MARK: - Interactor
    
    private var interactor: BeginnerHomeInteracting?
    
    // MARK: - Init
    
    init(interactor: BeginnerHomeInteracting?) {
        super.init(frame: .zero)
        self.interactor = interactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        interactor = nil
    }
}

extension BeginnerResultView: BeginnerResultDisplaying {
    func display() {
        //Something
    }
}
