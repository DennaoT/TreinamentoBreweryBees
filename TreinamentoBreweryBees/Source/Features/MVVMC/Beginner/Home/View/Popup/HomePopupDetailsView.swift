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
        static let titleHeight: CGFloat = .measurement(.small)
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
    
    private lazy var icon: BreweryIconView = BreweryIconView()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: Constants.titleHeight)
        label.textAlignment = .left
        label.contentMode = .scaleAspectFit
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var ratingView: RatingView = RatingView()
    
    private lazy var quantityRating: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: Constants.titleHeight)
        label.textAlignment = .left
        label.contentMode = .scaleAspectFit
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var establishmentTitle: UILabel = {
        .getTitleSectionValues(
            text: TreinamentoBreweryBeesLocalizable.breweryDetails_EstablishmentTitle.localized,
            height: Constants.titleHeight
        )
    }()
    
    private lazy var establishmentValue: UILabel = {
        .getTitleSectionValues(
            height: Constants.titleHeight,
            isBold: false,
            alignment: .right
        )
    }()
    
    private lazy var websiteTitle: UILabel = {
        .getTitleSectionValues(
            text: TreinamentoBreweryBeesLocalizable.breweryDetails_WebsiteTitle.localized,
            height: Constants.titleHeight
        )
    }()
    
    private lazy var websiteValue: UILabel = {
        .getTitleSectionValues(
            height: Constants.titleHeight,
            isBold: false,
            alignment: .right
        )
    }()
    
    private lazy var addressTitle: UILabel = {
        .getTitleSectionValues(
            text: TreinamentoBreweryBeesLocalizable.breweryDetails_AddressTitle.localized,
            height: Constants.titleHeight
        )
    }()
    
    private lazy var addressValue: UILabel = {
        .getTitleSectionValues(
            height: Constants.titleHeight,
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
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: Constants.titleHeight)
        label.textAlignment = .left
        label.contentMode = .scaleAspectFit
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var resultIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(asset: BreweryBeesAssets.Icons.beesMapIcon)
        imageView.sizeToFit()
        return imageView
    }()
    
    private lazy var resultTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: Constants.titleHeight)
        label.textAlignment = .left
        label.contentMode = .scaleAspectFit
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var rateButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
            .systemFont(ofSize: height)
        label.textAlignment = alignment
        label.contentMode = .scaleAspectFit
        label.numberOfLines = 2
        return label
    }
}
