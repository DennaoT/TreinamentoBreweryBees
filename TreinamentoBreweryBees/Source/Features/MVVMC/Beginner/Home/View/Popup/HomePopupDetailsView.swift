//
//  HomePopupDetailsView.swift
//  TreinamentoBreweryBees
//
//  Created by Dennis Torres on 15/04/24.
//

import UIKit
import SnapKit

class HomePopupDetailsView: UIView {
    
    // MARK: - Model
    
    struct Model {
        let breweryData: BreweryData?
        let evaluateAction: ActionHandler?
        let urlAction: UrlActionHandler?
        
        public init(
            breweryData: BreweryData?,
            evaluateAction: ActionHandler? = nil,
            urlAction: UrlActionHandler? = nil
        ) {
            self.breweryData = breweryData
            self.evaluateAction = evaluateAction
            self.urlAction = urlAction
        }
    }
    
    // MARK: - Enums
    
    private enum Constants {
        static let shadowColor: UIColor = .black.withAlphaComponent(0.2)
        static let shadowRadius: CGFloat = .measurement(.initialMedium)
        static let mainViewColor: UIColor = .white
        static let mainLeading : CGFloat = 3
        static let mainTrailing : CGFloat = 2.2
        static let mainBottom: CGFloat = 4.1
        static let smallSpacing: CGFloat = .measurement(.nano)
        static let defaultSpacing: CGFloat = .measurement(.small)
        static let nameTitleHeight: CGFloat = .measurement(.big)
        static let topicTitleHeight: CGFloat = .measurement(.initialMedium)
        static let ratingHeight: CGFloat = .measurement(.smaller)
        static let titleNumOfLines: Int = 2
        static let alreadyRatedTitleColor: UIColor = .init(hex: "#03AD00")
        static let verticalSpacing: CGFloat = .measurement(.big)
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
        label.font = .boldSystemFont(ofSize: Constants.nameTitleHeight)
        label.textAlignment = .left
        label.contentMode = .scaleAspectFit
        label.numberOfLines = Constants.titleNumOfLines
        return label
    }()
    
    private lazy var ratingView: RatingView = RatingView()
    
    private lazy var quantityRating: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: Constants.ratingHeight, weight: .thin)
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
        .getTitleSectionValues(
            height: Constants.topicTitleHeight,
            isBold: false,
            alignment: .right
        )
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
        return imageView
    }()
    
    private lazy var mapsTitle: UILabel = {
        .getTitleSectionValues(
            text: TreinamentoBreweryBeesLocalizable.breweryDetails_MapsTextLink.localized,
            height: Constants.topicTitleHeight
        )
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
              let numRating = model?.breweryData?.rating.quantityRating
        else { return }
        
        breweryIcon.setup(
            name: model?.breweryData?.name,
            image: model?.breweryData?.logo?.image,
            iconSize: Constants.breweryIconSize
        )
        mainView.addSubview(breweryIcon)
        breweryIcon.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(22)
            make.leading.equalToSuperview().inset(32)
            make.size.equalTo(Constants.breweryIconSize)
        }
        
        mainView.addSubview(topCornerStack)
        topCornerStack.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(22)
            make.trailing.equalToSuperview().inset(32)
        }
        
        titleLabel.text = breweryTitle
        quantityRating.text = numRating
        
        topCornerStack.addArrangedSubviews(titleLabel, ratingView, quantityRating)
        
        ratingView.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.width.equalTo(150) /// `150`
        }
        
        ratingView.setup(
            .seeReview(
                model?.breweryData?.rating.value,
                showLeftNumber:
                        .showLeftNumber(
                            sizeOfNumberLabel: 30
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
            make.top.equalTo(topCornerStack.snp.bottom).offset(Constants.defaultSpacing)
        }
        
        establishmentValue.text = establishmentText
        createEachMiddleSection(topic: establishmentTitle, value: establishmentValue)
        
        websiteValue.text = websiteText
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
            make.height.equalTo(insertMap ? (32.0 * 2.8) : 32.0)
            make.leading.trailing.equalToSuperview()
        }
        
        seactionView.addSubviews(topic, value)
        topic.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.width.equalTo(90.0)
        }
        value.snp.makeConstraints { make in
            make.trailing.top.bottom.equalToSuperview()
            make.leading.equalTo(topic.snp.trailing).offset(8.0)
        }
        
        guard insertMap
        else {
            middleStack.addArrangedSubview(.getLineDivisor())
            return
        }
        
        seactionView.addSubviews(mapsIcon, mapsTitle)
        mapsIcon.snp.makeConstraints { make in
            make.top.equalTo(value.snp.bottom).inset(4.0)
            make.leading.bottom.equalToSuperview()
            make.width.equalTo(70.0)
        }
        mapsTitle.snp.makeConstraints { make in
            make.top.equalTo(value.snp.bottom).inset(4.0)
            make.trailing.bottom.equalToSuperview()
            make.leading.equalTo(topic.snp.trailing).offset(8.0)
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(setupWebsiteURL(_:)))
        mapsIcon.isUserInteractionEnabled = true
        mapsTitle.isUserInteractionEnabled = true
        mapsIcon.addGestureRecognizer(tap)
        mapsTitle.addGestureRecognizer(tap)
        
        middleStack.addArrangedSubview(.getLineDivisor())
    }
    
    private func setupBottomSection() {
        guard let breweryData = model?.breweryData,
              breweryData.rating.userHasAlreadyRated
        else {
            evaluateButton.addTarget(self, action: #selector(buttonEvaluate), for: .touchUpInside)
            mainView.addSubview(evaluateButton)
            
            evaluateButton.snp.makeConstraints { make in
                if let lastViewBottom = mainView.subviews.last?.snp.bottom {
                    make.top.equalTo(lastViewBottom)
                    make.leading.trailing.bottom.equalToSuperview()
                    make.height.equalTo(70)
                    make.width.equalTo(260)
                }
            }
            return
        }
        
        mainView.addSubviews(alreadyRatedIcon, alreadyRatedTitle)
        
        if let lastViewBottom = mainView.subviews.last?.snp.bottom {
            alreadyRatedIcon.snp.makeConstraints { make in
                make.top.equalTo(lastViewBottom).inset(16)
                make.leading.bottom.equalToSuperview()
                make.size.equalTo(Constants.breweryIconSize)
            }
            
            alreadyRatedTitle.snp.makeConstraints { make in
                make.top.equalTo(alreadyRatedIcon.snp.top)
                make.trailing.bottom.equalToSuperview()
                make.height.equalTo(alreadyRatedIcon.snp.height)
                make.leading.equalTo(alreadyRatedIcon.snp.trailing)
//                make.width.equalTo(220)
            }
        }
    }
    
    @objc
    private func setupWebsiteURL(_ sender: UITapGestureRecognizer) {
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
    private func buttonEvaluate() {
        guard let action = model?.evaluateAction else { return }
        action()
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
