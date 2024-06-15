//
//  HomePopupDetailsView.swift
//  TreinamentoBreweryBees
//
//  Created by Dennis Torres on 15/04/24.
//

import UIKit
import SnapKit

class HomePopupDetailsView: UIView {
    
    // MARK: - Typealias
    private typealias QuantityRating = (roundedNumber: CGFloat, isMultipleOfHundred: Bool)
    
    // MARK: - Model
    
    struct Model {
        let breweryData: BreweryData?
        let evaluateAction: ActionHandler?
        let mapsAction: StringActionHandler?
        let urlAction: UrlActionHandler?
        
        public init(
            breweryData: BreweryData?,
            evaluateAction: ActionHandler? = nil,
            mapsAction: StringActionHandler? = nil,
            urlAction: UrlActionHandler? = nil
        ) {
            self.breweryData = breweryData
            self.evaluateAction = evaluateAction
            self.mapsAction = mapsAction
            self.urlAction = urlAction
        }
    }
    
    // MARK: - Enums
    
    private enum Constants {
        static let shadowColor: UIColor = .black.withAlphaComponent(0.2)
        static let shadowRadius: CGFloat = .measurement(.initialMedium)
        static let mainViewColor: UIColor = .white
        static let quantityTextColor: UIColor = .init(hex: "#A5A5A5")
        static let mainLeading : CGFloat = 3
        static let mainTrailing : CGFloat = 2.2
        static let mainBottom: CGFloat = 4.1
        static let topStackSpacing: CGFloat = 22
        static let smallSpacing: CGFloat = .measurement(.nano)
        static let mediumSpacing: CGFloat = .measurement(.extraSmall)
        static let defaultSpacing: CGFloat = .measurement(.small)
        static let largeSpacing: CGFloat = .measurement(.big)
        static let bigSpacing: CGFloat = .measurement(.xBig)
        static let sectionHeight: CGFloat = 32
        static let sectionHeightMultiplier: CGFloat = 3
        static let defaultComponentHeight: CGFloat = 28.0
        static let buttonEvaluateHeight: CGFloat = 52.0
        static let ratingHeight: CGFloat = 30.0
        static let ratingWidth: CGFloat = 150.0
        static let topicWidth: CGFloat = 90.0
        static let topicTitleHeight: CGFloat = .measurement(.initialMedium)
        static let ratingQuantityHeight: CGFloat = .measurement(.smaller)
        static let titleNumOfLines: Int = 2
        static let alreadyRatedTitleColor: UIColor = .init(hex: "#03AD00")
        static let verticalSpacing: CGFloat = .measurement(.large)
        static let breweryIconSize: CGFloat = .measurement(.giga)
        static let buttonEvaluateColor = UIColor(asset: BreweryBeesAssets.Colors.beesThemeColor)
        static let buttonEvaluateRadius: CGFloat = .measurement(.extraSmall)
        static let modalHeight: CGFloat = UIScreen.main.bounds.height * 0.7
        static let modalWidth: CGFloat = UIScreen.main.bounds.width - ((16 - (mainLeading + mainTrailing)) * 2)
    }
    
    // MARK: - Views
    
    private lazy var mainView: UIView = {
        let backgroundView = UIView()
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.backgroundColor = Constants.mainViewColor
        return backgroundView
    }()
    
    private lazy var topCornerStack: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = Constants.smallSpacing
        return stackView
    }()
    
    private lazy var middleStack: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = Constants.defaultSpacing
        return stackView
    }()
    
    private lazy var mainStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.spacing = Constants.defaultSpacing
        return stackView
    }()
    
    private lazy var breweryIcon: BreweryIconView = BreweryIconView()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: Constants.defaultComponentHeight)
        label.textAlignment = .left
        label.contentMode = .scaleAspectFit
        label.numberOfLines = Constants.titleNumOfLines
        return label
    }()
    
    private lazy var ratingView: RatingView = RatingView()
    
    private lazy var quantityRating: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Constants.quantityTextColor
        label.font = .systemFont(ofSize: Constants.ratingQuantityHeight, weight: .thin)
        label.textAlignment = .left
        label.contentMode = .scaleAspectFit
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var establishmentTitle: UILabel = {
        .getTitleSectionValues(
            text: TreinamentoBreweryBeesLocalizable.breweryDetails_EstablishmentTitle.localized,
            height: Constants.topicTitleHeight
        )
    }()
    
    private lazy var establishmentValue: UILabel = {
        .getTitleSectionValues(
            height: Constants.topicTitleHeight,
            isBold: false,
            alignment: .right
        )
    }()
    
    private lazy var websiteTitle: UILabel = {
        .getTitleSectionValues(
            text: TreinamentoBreweryBeesLocalizable.breweryDetails_WebsiteTitle.localized,
            height: Constants.topicTitleHeight
        )
    }()
    
    private lazy var websiteValue: UILabel = {
        let label: UILabel
        label = .getTitleSectionValues(
            height: Constants.topicTitleHeight,
            isBold: false,
            alignment: .right
        )
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(actionWebsiteURL(_:)))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(tap)
        
        return label
    }()
    
    private lazy var addressTitle: UILabel = {
        .getTitleSectionValues(
            text: TreinamentoBreweryBeesLocalizable.breweryDetails_AddressTitle.localized,
            height: Constants.topicTitleHeight
        )
    }()
    
    private lazy var addressValue: UILabel = {
        .getTitleSectionValues(
            height: Constants.topicTitleHeight,
            isBold: false,
            alignment: .right
        )
    }()
    
    private lazy var mapsIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(asset: BreweryBeesAssets.Icons.beesMapIcon)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(actionMaps))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tap)
        
        return imageView
    }()
    
    private lazy var mapsTitle: UILabel = {
        let label: UILabel
        label = .getTitleSectionValues(
            text: TreinamentoBreweryBeesLocalizable.breweryDetails_MapsTextLink.localized,
            height: Constants.topicTitleHeight
        )
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(actionMaps))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(tap)
        
        return label
    }()
    
    private lazy var alreadyRatedIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(asset: BreweryBeesAssets.Icons.beesSuccessBeerIcon)
        imageView.sizeToFit()
        return imageView
    }()
    
    private lazy var alreadyRatedTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = TreinamentoBreweryBeesLocalizable.breweryDetails_AlreadyRated.localized
        label.textColor = Constants.alreadyRatedTitleColor
        label.font = .boldSystemFont(ofSize: Constants.topicTitleHeight)
        label.textAlignment = .center
        label.contentMode = .scaleAspectFit
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var evaluateButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Constants.buttonEvaluateColor
        button.layer.cornerRadius = Constants.buttonEvaluateRadius
        button.setTitle(TreinamentoBreweryBeesLocalizable.breweryDetails_RateButton.localized, for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    // MARK: - Properties
    
    private var isModal: Bool = false
    private var model: HomePopupDetailsView.Model?
    
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
    
    func setup(with model: HomePopupDetailsView.Model?, isModal: Bool = false) {
        self.model = model
        self.isModal = isModal
        
        buildComponents()
    }
    
    // MARK: - Private methods
    
    private func buildComponents() {
        setupShadowView()
        setupMainView()
        setupTopSection()
        setupMiddleSection()
        setupBottomSection()
    }
    
    private func setupShadowView() {
        backgroundColor = Constants.shadowColor
        layer.cornerRadius = isModal ? Constants.shadowRadius : .zero
        
        guard isModal else { return }
        
        mainView.layer.cornerRadius = Constants.shadowRadius
        
        snp.makeConstraints { make in
            make.height.equalTo(Constants.modalHeight)
            make.width.equalTo(Constants.modalWidth)
        }
    }
    
    private func setupMainView() {
        addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(Constants.mainLeading)
            make.trailing.equalToSuperview().inset(Constants.mainTrailing)
            make.bottom.equalToSuperview().inset(Constants.mainBottom)
        }
    }
    
    private func setupTopSection() {
        guard let breweryTitle = model?.breweryData?.name,
              let numRating = model?.breweryData?.rating.quantityRating,
              let numRating = Double(numRating)
        else { return }
        
        breweryIcon.setup(
            name: model?.breweryData?.name,
            image: model?.breweryData?.logo?.image,
            iconSize: Constants.breweryIconSize
        )
        mainView.addSubview(breweryIcon)
        breweryIcon.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Constants.topStackSpacing)
            make.leading.equalToSuperview().inset(Constants.largeSpacing)
            make.size.equalTo(Constants.breweryIconSize)
        }
        
        mainView.addSubview(topCornerStack)
        topCornerStack.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Constants.topStackSpacing)
            make.trailing.equalToSuperview().inset(Constants.largeSpacing)
        }
        
        titleLabel.text = breweryTitle
        
        let displayQuantityRating: QuantityRating = roundRatingNumberAndCheck(CGFloat(numRating))
        
        quantityRating.text =
        displayQuantityRating.isMultipleOfHundred
        ? String(format: TreinamentoBreweryBeesLocalizable.breweryDetails_RateQuantity.localized, numRating)
        : String(format: TreinamentoBreweryBeesLocalizable.breweryDetails_RateQuantityMoreThan.localized, String(describing: displayQuantityRating.roundedNumber.formatted()))
        
        topCornerStack.addArrangedSubviews(titleLabel, ratingView, quantityRating)
        
        ratingView.snp.makeConstraints { make in
            make.height.equalTo(Constants.ratingHeight)
            make.width.equalTo(Constants.ratingWidth)
        }
        
        ratingView.setup(
            .seeReview(
                model?.breweryData?.rating.value,
                showLeftNumber:
                        .showLeftNumber(
                            sizeOfNumberLabel: Constants.ratingHeight
                        )
            )
        )
    }
    
    private func setupMiddleSection() {
        guard let establishmentText = model?.breweryData?.type,
              let websiteText = model?.breweryData?.website,
              let addressText = model?.breweryData?.address
        else { return }
        
        mainView.addSubview(middleStack)
        
        middleStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Constants.defaultSpacing)
            make.top.equalTo(topCornerStack.snp.bottom).offset(Constants.verticalSpacing).priority(.medium)
        }
        
        establishmentValue.text = establishmentText
        createEachMiddleSection(topic: establishmentTitle, value: establishmentValue)
        
        websiteValue.text = .getFormatURL(websiteText, removeSufix: true)
        createEachMiddleSection(topic: websiteTitle, value: websiteValue)
        
        addressValue.text = addressText
        createEachMiddleSection(topic: addressTitle, value: addressValue, insertMap: true)
    }
    
    private func createEachMiddleSection(
        topic: UILabel,
        value: UILabel,
        insertMap: Bool = false
    ) {
        let seactionView = UIView()
        seactionView.translatesAutoresizingMaskIntoConstraints = false
        
        middleStack.addArrangedSubview(seactionView)
        seactionView.snp.makeConstraints { make in
            make.height.equalTo(insertMap ? (Constants.sectionHeight * Constants.sectionHeightMultiplier) : Constants.sectionHeight)
            make.leading.trailing.equalToSuperview()
        }
        
        seactionView.addSubviews(topic, value)
        topic.snp.makeConstraints { make in
            make.leading.top.equalToSuperview()
            make.width.equalTo(Constants.topicWidth)
        }
        value.snp.makeConstraints { make in
            make.trailing.top.equalToSuperview()
            make.leading.equalTo(topic.snp.trailing).offset(Constants.mediumSpacing)
        }
        
        let lineDivisor: UIView = .getLineDivisor()
        middleStack.addArrangedSubview(lineDivisor)
        lineDivisor.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
        }
        
        guard insertMap else { return }
        
        seactionView.addSubviews(mapsIcon, mapsTitle)
        mapsIcon.snp.makeConstraints { make in
            make.height.equalTo(Constants.defaultComponentHeight)
            make.leading.bottom.equalToSuperview()
            make.width.equalTo(Constants.defaultComponentHeight)
        }
        mapsTitle.snp.makeConstraints { make in
            make.height.equalTo(Constants.defaultComponentHeight)
            make.bottom.equalToSuperview()
            make.leading.equalTo(mapsIcon.snp.trailing).offset(Constants.mediumSpacing)
        }
    }
    
    private func setupBottomSection() {
        guard let breweryData = model?.breweryData,
              breweryData.rating.userHasAlreadyRated
        else {
            evaluateButton.addTarget(self, action: #selector(actionButtonEvaluate), for: .touchUpInside)
            mainView.addSubview(evaluateButton)
            
            evaluateButton.snp.makeConstraints { make in
                make.height.equalTo(Constants.buttonEvaluateHeight)
                make.leading.trailing.equalToSuperview().inset(Constants.bigSpacing)
                make.bottom.equalToSuperview().inset(Constants.defaultComponentHeight)
            }
            return
        }
        
        mainView.addSubviews(alreadyRatedIcon, alreadyRatedTitle)
        
        alreadyRatedIcon.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(Constants.defaultSpacing)
            make.bottom.equalToSuperview().inset(Constants.largeSpacing)
            make.size.equalTo(Constants.breweryIconSize)
        }
        
        alreadyRatedTitle.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview().inset(Constants.largeSpacing)
            make.leading.equalTo(alreadyRatedIcon.snp.trailing).offset(Constants.largeSpacing)
        }
    }
    
    @objc
    private func actionWebsiteURL(_ sender: UITapGestureRecognizer) {
        guard sender.numberOfTouchesRequired == 1,
              let action = model?.urlAction
        else { return }
        
        if sender.numberOfTapsRequired == 1 {
            action(model?.breweryData?.website, .copy)
        } else if sender.numberOfTapsRequired == 2 {
            action(model?.breweryData?.website, .open)
        }
    }
    
    @objc
    private func actionMaps() {
        guard let action = model?.mapsAction,
              let dataModel = model?.breweryData
        else { return }
        action(dataModel.address)
    }
    
    @objc
    private func actionButtonEvaluate() {
        guard let action = model?.evaluateAction else { return }
        action()
    }
}

extension HomePopupDetailsView {
    private func roundRatingNumberAndCheck(_ number: CGFloat) -> QuantityRating {
        if number.truncatingRemainder(dividingBy: 100) == 0 {
            return (number, true)
        }
        
        if number <= 100 {
            return (number, false)
        }
        
        let hundreds = Int(number) / 100
        
        return (CGFloat(hundreds * 100), false)
    }
}

extension UILabel {
    static func getTitleSectionValues(
        text: String = "",
        height: CGFloat,
        isBold: Bool = true,
        alignment: NSTextAlignment = .left
    ) -> UILabel {
        let label = UILabel()
        label.text = text
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = isBold ?
            .boldSystemFont(ofSize: height) :
            .systemFont(ofSize: height, weight: .thin)
        label.textAlignment = alignment
        label.contentMode = .scaleAspectFit
        label.numberOfLines = 2
        return label
    }
}
