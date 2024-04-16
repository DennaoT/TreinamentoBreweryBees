//
//  GenericErrorView.swift
//  TreinamentoBreweryBees
//
//  Created by Dennis Torres on 15/04/24.
//

import UIKit
import SnapKit

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
    
    // MARK: - Enum
    
    private enum Constants {
        static let shadowColor: UIColor = .lightGray.withAlphaComponent(0.3)
        static let mainViewColor: UIColor = .yellow
        static let mainViewRadius: CGFloat = 16
        static let spacingSides: CGFloat = .measurement(.initialMedium)
        static let spacingTexts: CGFloat = .measurement(.large)
        static let titleColor: UIColor = .black
        static let titleHeight: CGFloat = 28
        static let descriptionColor: UIColor = .black
        static let descriptionHeight: CGFloat = .measurement(.initialMedium)
        static let buttonHeight: CGFloat = .measurement(.giga)
        static let buttonColor: UIColor = .white
        static let buttonTextColor: UIColor = .black
        static let buttonRadius: CGFloat = 12
        static let spacingToButton: CGFloat = 170
        static let borderSides: CGFloat = 2
        static let borderBottom: CGFloat = 5
        static let scaleAnimation: CGFloat = 0.95
    }
    
    // MARK: - Views
    
    private lazy var mainBackground: UIView = {
        let backgroundView = UIView()
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.backgroundColor = Constants.mainViewColor
        backgroundView.layer.cornerRadius = Constants.mainViewRadius
        return backgroundView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing = Constants.spacingTexts
        stackView.backgroundColor = Constants.mainViewColor
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Constants.titleColor
        label.font = .boldSystemFont(ofSize: Constants.titleHeight)
        label.textAlignment = .center
        label.contentMode = .scaleAspectFit
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Constants.descriptionColor
        label.font = .systemFont(ofSize: Constants.descriptionHeight)
        label.contentMode = .scaleAspectFit
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var tryAgainButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Constants.buttonColor
        button.layer.cornerRadius = Constants.buttonRadius
        button.setTitleColor(Constants.buttonTextColor, for: .normal)
        button.contentMode = .center
        return button
    }()
    
    // MARK: - Properties
    
    private var activeTasksCount = 0
    private var model: GenericErrorView.Model?
    
    // MARK: - Public methods
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with model: GenericErrorView.Model?) {
        guard let model = model else { return }
        self.model = model
        
        buildComponents()
    }
    
    // MARK: - Private methods
    
    private func buildComponents() {
        buildMain()
        buildTitle()
        buildDescription()
        buildButton()
    }
    
    private func buildMain() {
        self.backgroundColor = Constants.shadowColor
        self.layer.cornerRadius = Constants.mainViewRadius
        self.clipsToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(mainBackground)
        mainBackground.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(Constants.borderSides)
            $0.bottom.equalToSuperview().inset(Constants.borderBottom)
        }
        
        mainBackground.addSubview(mainStackView)
        mainStackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview()
        }
    }
    
    private func buildTitle() {
        titleLabel.text = model?.titleText
        mainStackView.addArrangedSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(Constants.spacingSides)
            $0.trailing.equalToSuperview().inset(-Constants.spacingSides)
            $0.height.equalTo(Constants.titleHeight)
        }
    }
    
    private func buildDescription() {
        guard let descriptionText = model?.descriptionText,
              !descriptionText.isEmpty
        else { return }
        
        descriptionLabel.text = descriptionText
        mainStackView.addArrangedSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Constants.spacingSides)
            $0.trailing.equalToSuperview().inset(-Constants.spacingSides)
            $0.height.equalTo(70)
        }
    }
    
    private func buildButton() {
        guard let buttonAction = model?.buttonAction,
              let lastElement = mainStackView.subviews.last
        else { return }
        
        mainStackView.setCustomSpacing(Constants.spacingToButton, after: lastElement)
        
        let action = UIAction { [weak self] _ in
            
            guard let activeTasksCount = self?.activeTasksCount, activeTasksCount < 3 else { return }
            
            UIView.animate(withDuration: 0.1) {
                self?.tryAgainButton.transform = CGAffineTransform(scaleX: Constants.scaleAnimation, y: Constants.scaleAnimation)
                self?.tryAgainButton.backgroundColor = .gray.withAlphaComponent(0.4)
                self?.tryAgainButton.isUserInteractionEnabled = false
                self?.activeTasksCount += 1
            }
            
            buttonAction()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                UIView.animate(withDuration: 0.4) {
                    self?.tryAgainButton.transform = CGAffineTransform.identity
                    self?.tryAgainButton.backgroundColor = Constants.buttonColor
                    self?.tryAgainButton.isUserInteractionEnabled = true
                    self?.activeTasksCount -= 1
                }
            }
        }
        tryAgainButton.addAction(action, for: .primaryActionTriggered)
        tryAgainButton.setTitle(model?.buttonText, for: .normal)
        
        mainStackView.addArrangedSubview(tryAgainButton)
        tryAgainButton.snp.makeConstraints {
            $0.height.equalTo(Constants.buttonHeight)
            $0.leading.trailing.equalToSuperview().inset(Constants.spacingSides)
        }
    }
}

// MARK: - Loading Functions

extension GenericErrorView {
    public func startGenericErrorLoading() {
        backgroundColor = .green
        
        mainStackView.isHidden = true
    }
    
    public func stopGenericErrorLoading() {
        backgroundColor = Constants.mainViewColor
        
        mainStackView.isHidden = false
    }
}
