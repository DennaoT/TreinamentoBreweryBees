//
//  HomeModalView.swift
//  TreinamentoBreweryBees
//
//  Created by Dennis Torres on 15/04/24.
//

import UIKit
import SnapKit

class HomeModalView: UIView {
    
    // MARK: - Type
    
    enum PopupType {
        case rating(model: HomeModalView.Model)
        case ratingSuccess
        case ratingFailed
    }
    
    // MARK: - Model
    
    struct Model {
        var hasDefaultHeight: Bool = false
        var verifyEmail: VerifyStringHandler?
        var evaluateAction: StringsActionHandler?
        let breweryData: BreweryData?
        
        public init(
            breweryData: BreweryData?,
            evaluateAction: StringsActionHandler? = nil,
            verifyEmail: VerifyStringHandler? = nil,
            hasDefaultHeight: Bool = false
        ) {
            self.breweryData = breweryData
            self.evaluateAction = evaluateAction
            self.verifyEmail = verifyEmail
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
        static let resultIconSize: CGFloat = 80.0
        static let resultLabelHeight: CGFloat = 18.0
        static let titleHeight: CGFloat = 25.0
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
    
    private lazy var resultIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var resultDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: Constants.resultLabelHeight, weight: .semibold)
        label.textAlignment = .center
        label.contentMode = .scaleAspectFit
        label.numberOfLines = Constants.titleNumOfLines
        return label
    }()
    
    // MARK: - Properties
    
    private var rateValue: String?
    private var isEmailValid: Bool = false
    private var dismissAction: ActionHandler?
    private var modelType: PopupType?
    
    // MARK: - Public methods
    
    init() {
        super.init(frame: .zero)
    }
    
    convenience init(type: PopupType, dismissAction: ActionHandler? = nil) {
        self.init()
        setup(type: type, dismissAction: dismissAction)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        rateValue = nil
        dismissAction = nil
        modelType = nil
    }
    
    func setup(type: PopupType, dismissAction: ActionHandler? = nil) {
        self.modelType = type
        self.dismissAction = dismissAction
        
        buildComponents()
    }
    
    // MARK: - Private methods
    
    private func buildComponents() {
        backgroundColor = Constants.mainViewColor
        isUserInteractionEnabled = true
        
        resetViews()
        setupElements()
        setupHierarchy()
        setupConstraints()
    }
    
    private func resetViews() {
        textFieldStack.removeAllArrangedSubviews()
        mainStackView.removeAllArrangedSubviews()
        removeSubviews()
    }
    
    private func setupElements() {
        guard let modelType = modelType else { return }
        setupCloseAction()
        
        switch modelType {
        case .rating(let model):
            guard let titleText = model.breweryData?.name else { return }
            titleLabel.text = String(
                format: TreinamentoBreweryBeesLocalizable.breweryRatingTitle.localized,
                titleText
            )
            ratingView.setup(.toEvaluate(evaluateAction: { [weak self] value in
                self?.rateValue = value
                self?.enableSaveButton()
            }))
            ratingView.isUserInteractionEnabled = true
        case .ratingSuccess:
            titleLabel.text = TreinamentoBreweryBeesLocalizable.successTitle.localized
            resultIcon.image = UIImage(asset: BreweryBeesAssets.Icons.beesSuccessBeerIcon)
            resultDescription.text = TreinamentoBreweryBeesLocalizable.successDescription.localized
            resultDescription.textColor = .green
            
        case .ratingFailed:
            titleLabel.text = TreinamentoBreweryBeesLocalizable.errorTitle.localized
            resultIcon.image = UIImage(asset: BreweryBeesAssets.Icons.beesFailedBeerIcon)
            resultDescription.text = TreinamentoBreweryBeesLocalizable.errorDescription.localized
            resultDescription.textColor = .red
        }
    }
    
    private func setupCloseAction() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(actionCloseButton))
        tapGesture.numberOfTapsRequired = 1
        closeIcon.addGestureRecognizer(tapGesture)
    }
    
    private func setupHierarchy() {
        addSubviews(closeIcon, mainStackView)
        mainStackView.addArrangedSubview(titleLabel)
        
        guard case .rating(_) = modelType else {
            mainStackView.addArrangedSubviews(
                resultIcon,
                resultDescription
            )
            return
        }
        
        mainStackView.addArrangedSubviews(
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
        if case .rating(let model) = modelType,
           model.hasDefaultHeight {
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
        
        guard case .rating(_) = modelType else {
            resultIcon.snp.makeConstraints { make in
                make.size.equalTo(Constants.resultIconSize)
            }
            return
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
        dismissAction?()
    }
    
    @objc
    private func actionSaveButton() {
        guard case .rating(let model) = modelType,
              let breweryId = model.breweryData?.identifier,
              let rateValue = rateValue
        else { return }
        
        model.evaluateAction?(breweryId, rateValue)
    }
    
    private func updateTextField(text: String) {
        guard case .rating(let model) = modelType else { return }
        
        isEmailValid = model.verifyEmail?(text) ?? false
        
        invalidEmailLabel.text = !isEmailValid
        ? TreinamentoBreweryBeesLocalizable.emailNotVerified.localized
        : " "
        enableSaveButton()
    }
    
    private func enableSaveButton() {
        guard rateValue != nil && isEmailValid
        else {
            saveButton.isEnabled = false
            saveButton.backgroundColor = Constants.buttonEvaluateColor?.withAlphaComponent(0.3)
            return
        }
        
        saveButton.isEnabled = true
        saveButton.backgroundColor = Constants.buttonEvaluateColor?.withAlphaComponent(1)
    }
}

extension HomeModalView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newText = (text as NSString).replacingCharacters(in: range, with: string)
        updateTextField(text: newText)
        return true
    }
}
