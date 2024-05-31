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
        static let titleContainerHeight: CGFloat = 80
        static let descriptionColor: UIColor = .black
        static let descriptionHeight: CGFloat = .measurement(.initialMedium)
        static let descriptionContainerHeight: CGFloat = 300
        static let buttonHeight: CGFloat = .measurement(.giga)
        static let buttonColor: UIColor = .white
        static let buttonTextColor: UIColor = .black
        static let buttonRadius: CGFloat = 12
        static let spacingToTop: CGFloat = 70
        static let spacingToButton: CGFloat = 70
        static let borderSides: CGFloat = 2
        static let borderBottom: CGFloat = 5
        static let scaleAnimation: CGFloat = 0.95
        static let timeAnimation: CGFloat = 0.4
        static let minimumPressDuration: CGFloat = 1.2
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
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Constants.titleColor
        label.font = .boldSystemFont(ofSize: Constants.titleHeight)
        label.textAlignment = .center
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Constants.descriptionColor
        label.font = .systemFont(ofSize: Constants.descriptionHeight)
        label.textAlignment = .center
        label.numberOfLines = .zero
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
    
    private var action: UIAction?
    private var model: GenericErrorView.Model?
    
    // MARK: - Public methods
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        action = nil
        model = nil
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
        setupButtonAction()
    }
    
    private func buildMain() {
        self.backgroundColor = Constants.shadowColor
        self.layer.cornerRadius = Constants.mainViewRadius
        self.clipsToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(mainBackground)
        mainBackground.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(Constants.borderSides)
            make.bottom.equalToSuperview().inset(Constants.borderBottom)
        }
        
        mainBackground.addSubview(mainStackView)
        mainStackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
    
    private func buildTitle() {
        titleLabel.text = model?.titleText
        mainStackView.addArrangedSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Constants.spacingToTop)
            make.leading.trailing.equalToSuperview().inset(Constants.spacingSides)
            make.height.equalTo(Constants.titleContainerHeight)
        }
    }
    
    private func buildDescription() {
        guard let descriptionText = model?.descriptionText,
              !descriptionText.isEmpty
        else { return }
        
        descriptionLabel.text = descriptionText
        mainStackView.addArrangedSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Constants.spacingSides)
            make.height.equalTo(Constants.descriptionContainerHeight)
        }
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(setupDescriptionAction))
        longPressGesture.minimumPressDuration = Constants.minimumPressDuration
        descriptionLabel.addGestureRecognizer(longPressGesture)
        descriptionLabel.isUserInteractionEnabled = true
    }
    
    @objc private func setupDescriptionAction(sender: UILongPressGestureRecognizer) {
        if case .began = sender.state {
            UIView.animate(withDuration: Constants.timeAnimation) {
                self.descriptionLabel.textColor = .blue
            }
        } else if case .ended = sender.state {
            UIView.animate(withDuration: Constants.timeAnimation) {
                self.descriptionLabel.textColor = Constants.descriptionColor
            }
            UIPasteboard.general.string = self.descriptionLabel.text
        }
    }
    
    private func buildButton() {
        guard let lastElement = mainStackView.subviews.last else { return }
        
        mainStackView.setCustomSpacing(Constants.spacingToButton, after: lastElement)
        
        tryAgainButton.setTitle(model?.buttonText, for: .normal)
        
        mainStackView.addArrangedSubview(tryAgainButton)
        tryAgainButton.snp.makeConstraints { make in
            make.height.equalTo(Constants.buttonHeight)
            make.leading.trailing.equalToSuperview().inset(Constants.spacingSides)
        }
    }
    
    private func setupButtonAction() {
        guard let buttonAction = model?.buttonAction else { return }
        
        resetActionIfNeeds()
        
        action = UIAction { [weak self] _ in
            UIView.animate(withDuration: Constants.timeAnimation) {
                self?.tryAgainButton.transform = CGAffineTransform(scaleX: Constants.scaleAnimation, y: Constants.scaleAnimation)
                self?.tryAgainButton.backgroundColor = .gray.withAlphaComponent(Constants.timeAnimation)
                self?.tryAgainButton.isUserInteractionEnabled = false
            } completion: { _ in
                self?.tryAgainButton.transform = CGAffineTransform.identity
                self?.tryAgainButton.backgroundColor = Constants.buttonColor
                self?.tryAgainButton.isUserInteractionEnabled = true
                buttonAction()
            }
        }
        
        guard let action = action else { return }
        tryAgainButton.addAction(action, for: .primaryActionTriggered)
    }
    
    private func resetActionIfNeeds() {
        guard model != nil, let action = action else { return }
        
        tryAgainButton.removeAction(action, for: .primaryActionTriggered)
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
