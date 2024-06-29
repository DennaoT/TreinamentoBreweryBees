//
//  HomePopupRatingView.swift
//  TreinamentoBreweryBees
//
//  Created by Dennis Torres on 15/04/24.
//

import UIKit
import SnapKit

class HomePopupRatingView: UIView {
    
    // MARK: - Model
    
    struct Model {
        var hasDefaultHeight: Bool = false
        var dismissAction: ActionHandler?
        var verifyEmail: VerifyStringHandler?
        var evaluateAction: StringsActionHandler?
        let breweryData: BreweryData?
        
        public init(
            breweryData: BreweryData?,
            evaluateAction: StringsActionHandler? = nil,
            verifyEmail: VerifyStringHandler? = nil,
            dismissAction: ActionHandler? = nil,
            hasDefaultHeight: Bool = false
        ) {
            self.breweryData = breweryData
            self.evaluateAction = evaluateAction
            self.verifyEmail = verifyEmail
            self.dismissAction = dismissAction
            self.hasDefaultHeight = hasDefaultHeight
        }
    }
    
    // MARK: - Enums
    
    private enum Constants {
        static let modalHeight: CGFloat = 420.0
        static let mainViewColor: UIColor = .white
        static let stackSpacing: CGFloat = .measurement(.medium)
        static let customSpacing: CGFloat = .measurement(.xBig)
        static let defaultSpacing: CGFloat = .measurement(.small)
        static let ratingHeight: CGFloat = 50.0
        static let ratingWidth: CGFloat = 240.0
        static let closeIconSize: CGFloat = 22.0
        static let titleHeight: CGFloat = 28.0
        static let titleNumOfLines: Int = 2
        static let textFieldHeight: CGFloat = 20.0
        static let lineDivisorHeight: CGFloat = 2.0
        static let warningHeight: CGFloat = 18.0
        static let textFieldSpacing: CGFloat = 0.7
        static let buttonEvaluateHeight: CGFloat = .measurement(.large)
        static let buttonEvaluateColor = UIColor(asset: BreweryBeesAssets.Colors.beesThemeColor)
        static let buttonEvaluateRadius: CGFloat = .measurement(.extraSmall)
    }
    
    // MARK: - Views
    
    private lazy var closeIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(systemName: "xmark")
        imageView.tintColor = .black
        return imageView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.spacing = Constants.stackSpacing
        return stackView
    }()
    
    private lazy var textFieldStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.axis = .vertical
        stackView.spacing = Constants.textFieldSpacing
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: Constants.titleHeight)
        label.textAlignment = .center
        label.contentMode = .scaleAspectFit
        label.numberOfLines = Constants.titleNumOfLines
        return label
    }()
    
    private lazy var ratingView: RatingView = RatingView()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .none
        textField.placeholder = TreinamentoBreweryBeesLocalizable.emailTextExample.localized
        textField.font = UIFont.systemFont(ofSize: Constants.textFieldHeight)
        textField.delegate = self
        return textField
    }()
    
    private lazy var lineDivisor: UIView = {
        return .getLineDivisor(height: Constants.lineDivisorHeight)
    }()
    
    private lazy var invalidEmailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = TreinamentoBreweryBeesLocalizable.emailNotVerified.localized
        label.textColor = .red
        label.font = .systemFont(ofSize: Constants.warningHeight, weight: .thin)
        label.textAlignment = .left
        label.contentMode = .scaleAspectFit
        return label
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Constants.buttonEvaluateColor?.withAlphaComponent(0.3)
        button.isEnabled = false
        button.layer.cornerRadius = Constants.buttonEvaluateRadius
        button.setTitle(TreinamentoBreweryBeesLocalizable.breweryButtonTitle.localized, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(actionSaveButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Properties
    
    private var rateValue: String?
    private var isEmailValid: Bool = false
    private var model: HomePopupRatingView.Model?
    
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
    
    func setup(with model: HomePopupRatingView.Model) {
        self.model = model
        
        buildComponents()
    }
    
    // MARK: - Private methods
    
    private func buildComponents() {
        backgroundColor = Constants.mainViewColor
        isUserInteractionEnabled = true
        
        setupElements()
        setupHierarchy()
        setupConstraints()
    }
    
    private func setupElements() {
        guard let breweryName = model?.breweryData?.name else { return }
        
        setupCloseAction()
        
        titleLabel.text = String(
            format: TreinamentoBreweryBeesLocalizable.breweryRatingTitle.localized,
            breweryName
        )
        
        ratingView.setup(.toEvaluate(evaluateAction: { [weak self] value in
            self?.rateValue = value
        }))
        ratingView.isUserInteractionEnabled = true
    }
    
    private func setupCloseAction() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(actionCloseButton))
        tapGesture.numberOfTapsRequired = 1
        closeIcon.addGestureRecognizer(tapGesture)
    }
    
    private func setupHierarchy() {
        addSubviews(closeIcon, mainStackView)
        mainStackView.addArrangedSubviews(
            titleLabel,
            ratingView,
            textFieldStack,
            saveButton
        )
        textFieldStack.addArrangedSubviews(
            textField,
            lineDivisor,
            invalidEmailLabel
        )
        mainStackView.setCustomSpacing(Constants.customSpacing, after: textFieldStack)
    }
    
    private func setupConstraints() {
        if model?.hasDefaultHeight ?? false {
            snp.makeConstraints { make in
                make.height.equalTo(Constants.modalHeight)
            }
        }
        
        closeIcon.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(Constants.defaultSpacing)
            make.size.equalTo(Constants.closeIconSize)
        }
        
        mainStackView.snp.makeConstraints { make in
            make.top.equalTo(closeIcon.snp.bottom).offset(Constants.defaultSpacing)
            make.leading.trailing.equalToSuperview()
        }
        
        textFieldStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Constants.defaultSpacing)
        }
        
        lineDivisor.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Constants.defaultSpacing)
        }
        
        ratingView.snp.makeConstraints { make in
            make.height.equalTo(Constants.ratingHeight)
            make.width.equalTo(Constants.ratingWidth)
        }
        
        saveButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Constants.defaultSpacing)
            make.height.equalTo(Constants.buttonEvaluateHeight)
        }
    }
    
    @objc
    private func actionCloseButton() {
        model?.dismissAction?()
    }
    
    @objc
    private func actionSaveButton() {
        guard let breweryId = model?.breweryData?.identifier,
              let rateValue = rateValue
        else { return }
        
        model?.evaluateAction?(breweryId, rateValue)
    }
    
    private func updateTextField(text: String) {
        isEmailValid = model?.verifyEmail?(text) ?? false
        
        invalidEmailLabel.text = !isEmailValid
        ? TreinamentoBreweryBeesLocalizable.emailNotVerified.localized
        : " "
        enableSaveButton()
    }
    
    private func enableSaveButton() {
        guard !saveButton.isEnabled
                && rateValue != nil
                && isEmailValid
        else {
            saveButton.isEnabled = false
            saveButton.backgroundColor = Constants.buttonEvaluateColor?.withAlphaComponent(0.3)
            return
        }
        
        saveButton.isEnabled = true
        saveButton.backgroundColor = Constants.buttonEvaluateColor?.withAlphaComponent(1)
    }
}

extension HomePopupRatingView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newText = (text as NSString).replacingCharacters(in: range, with: string)
        updateTextField(text: newText)
        return true
    }
}
