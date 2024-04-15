//
//  GenericErrorView.swift
//  TreinamentoBreweryBees
//
//  Created by Dennis Torres on 15/04/24.
//

import UIKit
//import SnapKit

class GenericErrorView: UIView {
    
    // MARK: - Model
    
    struct Model {
        var titleText: String
        var descriptionText: String?
        var buttonText: String
        var buttonAction: ActionHandler?
        
        public init(
            titleText: String,
            descriptionText: String? = nil,
            buttonText: String,
            buttonAction: ActionHandler? = nil
        ) {
            self.titleText = titleText
            self.descriptionText = descriptionText
            self.buttonText = buttonText
            self.buttonAction = buttonAction
        }
    }
    
    // MARK: - Constants
    
    private enum Constants {
        static let mainViewColor: UIColor = .yellow
        static let spacingSides: CGFloat = 16
        static let spacingTop: CGFloat = 20
        static let widgetRadius: CGFloat = 8
        static let titleColor: UIColor = .white
        static let titleHeight: CGFloat = 28
        static let buttonHeight: CGFloat = 35
        static let buttonColor: UIColor = .white
        static let buttonTextColor: UIColor = .white
        static let buttonRadius: CGFloat = 4
        static let spacingToButton: CGFloat = 40
    }
    
    // MARK: - Outlets
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing = Constants.spacingSides
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Constants.titleColor
        label.font = .boldSystemFont(ofSize: Constants.titleHeight)
        return label
    }()
    
    private lazy var tryAgainButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Constants.buttonColor
        button.layer.cornerRadius = Constants.buttonRadius
        button.setTitleColor(Constants.buttonTextColor, for: .normal)
        return button
    }()
    
    // MARK: - Properties
    
    private var model: GenericErrorView.Model?
    
    // MARK: - Public methods
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with model: GenericErrorView.Model?, action: @escaping ActionHandler) {
        guard let model = model else { return }
        self.model = model
        
        buildComponents()
    }
    
    // MARK: - Private methods
    
    private func buildComponents() {
        buildMain()
        buildTitle()
        buildButton()
    }
    
    private func buildMain() {
        self.backgroundColor = Constants.mainViewColor
        self.clipsToBounds = true
        self.layer.cornerRadius = Constants.widgetRadius
    }
    
    private func buildTitle() {
        titleLabel.text = model?.titleText
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.spacingTop)
            $0.leading.equalToSuperview().inset(Constants.spacingSides)
            $0.height.equalTo(Constants.titleHeight)
        }
    }
    
    private func buildButton() {
        guard let buttonAction = model?.buttonAction,
              let lastElement = mainStackView.subviews.last
        else { return }
        
        mainStackView.setCustomSpacing(Constants.spacingToButton, after: lastElement)
        
        let action = UIAction { _ in
            buttonAction()
        }
        tryAgainButton.addAction(action, for: .primaryActionTriggered)
        tryAgainButton.setTitle(model?.buttonText, for: .normal)
        
        tryAgainButton.snp.makeConstraints { make in
            make.height.equalTo(Constants.buttonHeight)
            //make.leading.trailing.equalToSuperview()
        }
    }
}

// MARK: - Loading Functions

extension GenericErrorView {
    public func startGenericErrorLoading() {
        backgroundColor = .green
    }
    
    public func stopGenericErrorLoading() {
        backgroundColor = Constants.mainViewColor
    }
}
