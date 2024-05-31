//
//  HomePopupDetailsView.swift
//  TreinamentoBreweryBees
//
//  Created by Dennis Torres on 15/04/24.
//

import UIKit
import SnapKit

class HomePopupDetailsView: UIView {
    
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
        stackView.axis = .vertical
        stackView.spacing = Constants.defaultSpacing
        return stackView
    }()
    
    // MARK: - Properties
    
    private var model: BreweryData?
    
    // MARK: - Public methods
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        model = nil
    }
    
    func setup(with model: BreweryData) {
        self.model = model
        
        buildComponents()
    }
    
    // MARK: - Private methods
    
    private func buildComponents() {
        guard let model = model else { return }
        
        backgroundColor = Constants.mainViewColor
    }
}

