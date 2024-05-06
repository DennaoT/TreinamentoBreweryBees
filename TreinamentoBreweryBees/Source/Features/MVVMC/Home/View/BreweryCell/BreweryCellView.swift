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
        static let mainViewHeight: CGFloat = 80
        static let defaultSpacing: CGFloat = .measurement(.smaller)
        static let defaultRadius: CGFloat = .measurement(.smaller)
        static let iconSize: CGFloat = .measurement(.big)
        static let titleColor: UIColor = .black
        static let titleHeight: CGFloat = 18
        static let descriptionColor: UIColor = .black
        static let descriptionHeight: CGFloat = 16
        static let ratingHeight: CGFloat = 30
        static let ratingWidth: CGFloat = 150
        static let defaultIconViewColor: UIColor = .init(hex: "#FFC366")
        static let defaultIconLabelColor: UIColor = .init(hex: "#8A7251")
    }
    
    // MARK: - Views
    
    private lazy var defaultIconView: UIView = {
        let backgroundView = UIView()
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.backgroundColor = Constants.defaultIconViewColor
        backgroundView.layer.cornerRadius = Constants.iconSize/2
        backgroundView.layer.masksToBounds = true
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
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = false
        imageView.clipsToBounds = true
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
        layer.cornerRadius = Constants.defaultRadius
        
        snp.makeConstraints { make in
            make.height.equalTo(Constants.mainViewHeight)
        }
    }
    
    private func buildIcon() {
        addSubview(defaultIconView)
        defaultIconView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(Constants.defaultSpacing)
            make.size.equalTo(Constants.iconSize)
        }
        
        buildImage()
    }
    
    /// `TO DO
    /// ``Aplicar melhoriar no Request das imagens por URL
    private func buildImage() {
        UIImage.loadFromURL(urlString: model?.logo) { [weak self] image in
            guard let self = self else { return }
            if let image = image {
                self.iconImage.image = image
                self.defaultIconView.addSubview(self.iconImage)
                self.iconImage.snp.makeConstraints { make in
                    make.center.equalToSuperview()
                    make.size.equalToSuperview()
                }
            } else {
                if let firstChar = self.model?.name.first {
                    self.defaultIconLabel.text = String(firstChar.uppercased())
                }
                
                self.defaultIconView.addSubview(self.defaultIconLabel)
                self.defaultIconLabel.snp.makeConstraints { make in
                    make.center.equalToSuperview()
                }
            }
        }
    }
    
    private func buildTitle() {
        titleLabel.text = model?.name
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(defaultIconView.snp.trailing).offset(Constants.defaultSpacing)
            make.top.trailing.equalToSuperview().inset(Constants.defaultSpacing)
            make.height.equalTo(Constants.titleHeight)
        }
    }
    
    private func buildRating() {
        addSubview(ratingView)
        ratingView.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview().inset(Constants.defaultSpacing)
            make.height.equalTo(Constants.ratingHeight)
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
        descriptionLabel.text = model?.type
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(defaultIconView.snp.trailing).offset(Constants.defaultSpacing)
            make.bottom.equalToSuperview().inset(Constants.defaultSpacing)
            make.height.equalTo(Constants.descriptionHeight)
            make.trailing.equalTo(ratingView.snp.leading)
        }
    }
}
