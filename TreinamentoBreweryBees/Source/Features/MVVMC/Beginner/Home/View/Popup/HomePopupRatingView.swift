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
        var evaluateAction: StringActionHandler?
        let breweryData: BreweryData?
        
        public init(
            breweryData: BreweryData?,
            evaluateAction: StringActionHandler? = nil,
            dismissAction: ActionHandler? = nil,
            hasDefaultHeight: Bool = false
        ) {
            self.breweryData = breweryData
            self.evaluateAction = evaluateAction
            self.dismissAction = dismissAction
            self.hasDefaultHeight = hasDefaultHeight
        }
    }
    
    // MARK: - Enums
    
    private enum Constants {
        static let modalHeight: CGFloat = 260.0
        static let mainViewColor: UIColor = .white
        static let defaultSpacing: CGFloat = .measurement(.small)
        static let closeIconHeight: CGFloat = 28.0
        static let titleHeight: CGFloat = 28.0
        static let textFieldHeight: CGFloat = 20.0
        static let lineDivisorHeight: CGFloat = 2.0
        static let warningHeight: CGFloat = 18.0
        static let warningSpacing: CGFloat = 0.7
        static let buttonEvaluateColor = UIColor(asset: BreweryBeesAssets.Colors.beesThemeColor)
        static let buttonEvaluateRadius: CGFloat = .measurement(.extraSmall)
    }
    
    // MARK: - Views
    
    private lazy var closeIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = false
        imageView.image = UIImage(systemName: "xmark")
        return imageView
    }()
    
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
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: Constants.titleHeight)
        label.textAlignment = .center
        label.contentMode = .scaleAspectFit
        return label
    }()
    
    private lazy var ratingView: RatingView = RatingView()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .none
        textField.placeholder = "Enter your feedback"
        textField.font = UIFont.systemFont(ofSize: Constants.textFieldHeight)
        textField.delegate = self
        return textField
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
        button.backgroundColor = Constants.buttonEvaluateColor
        button.layer.cornerRadius = Constants.buttonEvaluateRadius
        button.setTitle(TreinamentoBreweryBeesLocalizable.breweryButtonTitle.localized, for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    // MARK: - Properties
    
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
        
        setupElements()
        setupHierarchy()
        setupConstraints()
    }
    
    private func setupElements() {
        guard let breweryName = model?.breweryData?.name else { return }
        
        titleLabel.text = String(
            format: TreinamentoBreweryBeesLocalizable.breweryRatingTitle.localized,
            breweryName
        )
        
        ratingView.setup(.toEvaluate(evaluateAction: { [weak self] value in
            self?.model?.evaluateAction?(value)
        }))
    }
    
    private func setupHierarchy() {
        addSubviews(closeIcon, mainStackView)
        mainStackView.addSubviews(
            titleLabel,
            ratingView,
            textField,
                .getLineDivisor(height: Constants.lineDivisorHeight),
            invalidEmailLabel,
            saveButton
        )
    }
    
    private func setupConstraints() {
        if model?.hasDefaultHeight ?? false {
            snp.makeConstraints { make in
                make.height.equalTo(Constants.modalHeight)
            }
        }
        
        closeIcon.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(Constants.defaultSpacing)
            make.height.equalTo(Constants.closeIconHeight)
        }
        
        mainStackView.snp.makeConstraints { make in
            make.top.equalTo(closeIcon.snp.bottom).inset(Constants.defaultSpacing)
            make.leading.trailing.equalToSuperview()
        }
    }
}

extension HomePopupRatingView: UITextFieldDelegate {
    
}
