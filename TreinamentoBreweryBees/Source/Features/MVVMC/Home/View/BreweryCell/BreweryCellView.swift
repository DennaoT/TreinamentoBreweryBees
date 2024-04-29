//
//  BreweryCellView.swift
//  TreinamentoBreweryBees
//
//  Created by Dennis Torres on 24/04/24.
//

import UIKit
import SnapKit

class BreweryCellView: UIView {
    
    // MARK: - Enum
    
    private enum Constants {
        static let mainViewColor: UIColor = .white
        static let mainViewHeight: CGFloat = .measurement(.xLarge)
        static let defaultSpacing: CGFloat = .measurement(.smaller)
        static let iconSize: CGFloat = 26
        static let titleColor: UIColor = .black
        static let titleHeight: CGFloat = 18
        static let descriptionColor: UIColor = .black
        static let descriptionHeight: CGFloat = 16
        static let ratingHeight: CGFloat = 14
        static let ratingWidth: CGFloat = 124
        static let defaultIconViewColor: UIColor = .init(hex: "#FFC366")
        static let defaultIconLabelColor: UIColor = .init(hex: "#8A7251")
    }
    
    // MARK: - Views
    
    private lazy var defaultIconView: UIView = {
        let backgroundView = UIView()
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.backgroundColor = Constants.defaultIconViewColor
        backgroundView.layer.cornerRadius = Constants.iconSize/2
        return backgroundView
    }()
    
    private lazy var defaultIconLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Constants.defaultIconLabelColor
        label.font = .boldSystemFont(ofSize: Constants.iconSize * 0.8)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var iconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Constants.titleColor
        label.font = .boldSystemFont(ofSize: Constants.titleHeight)
        label.textAlignment = .left
        label.contentMode = .scaleAspectFit
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Constants.titleColor
        label.font = .systemFont(ofSize: Constants.descriptionHeight)
        label.textAlignment = .left
        label.contentMode = .scaleAspectFit
        return label
    }()
    
    private lazy var ratingView: RatingView = {
        RatingView()
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
    
    func setup(with model: BreweryData?) {
        guard let model = model else { return }
        
        self.model = model
        
        buildComponents()
    }
    
    // MARK: - Private methods
    
    private func buildComponents() {
        buildMain()
        buildIcon()
        buildTitle()
        buildRating()
        buildDescription()
    }
    
    private func buildMain() {
        backgroundColor = Constants.mainViewColor
        
        snp.makeConstraints { make in
            make.height.equalTo(Constants.mainViewHeight)
        }
    }
    
    private func buildIcon() {
        addSubview(defaultIconView)
        defaultIconView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().inset(Constants.defaultSpacing)
            make.size.equalTo(Constants.iconSize)
        }
        
        guard let image = UIImage.loadFromURL(urlString: model?.logo) else {
            if let firstChar = model?.name.first {
                defaultIconLabel.text = String(firstChar)
            }
            
            defaultIconView.addSubview(defaultIconLabel)
            defaultIconLabel.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
            return
        }
        
        iconImage.image = image
        defaultIconView.addSubview(iconImage)
        iconImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func buildTitle() {
        titleLabel.text = model?.name
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(defaultIconView.snp.trailing).inset(Constants.defaultSpacing)
            make.top.trailing.equalToSuperview().inset(Constants.defaultSpacing)
            make.height.equalTo(Constants.titleHeight)
        }
    }
    
    private func buildRating() {
        addSubview(ratingView)
        ratingView.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview().inset(Constants.defaultSpacing)
            make.height.equalTo(Constants.titleHeight)
            make.width.equalTo(Constants.ratingWidth)
        }
        
        ratingView.setup(
            .seeReview(
                model?.rating,
                showLeftNumber: .showLeftNumber(sizeOfNumberLabel: Constants.ratingHeight)
            )
        )
    }
    
    private func buildDescription() {
        descriptionLabel.text = model?.description
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(defaultIconView.snp.trailing).inset(Constants.defaultSpacing)
            make.bottom.equalToSuperview().inset(Constants.defaultSpacing)
            make.height.equalTo(Constants.descriptionHeight)
            make.trailing.equalTo(ratingView.snp.leading).inset(Constants.defaultSpacing)
        }
    }
}
