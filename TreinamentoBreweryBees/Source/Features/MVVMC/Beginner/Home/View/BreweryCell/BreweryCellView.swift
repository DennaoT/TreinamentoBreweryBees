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
    }
    
    // MARK: - Views
    
    private lazy var iconView: BreweryIconView = {
        BreweryIconView()
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
    
    deinit {
        model = nil
    }
    
    func setup(with model: BreweryData?) {
        guard let model = model else { return }
        self.model = model
        
        buildComponents()
    }
    
    func updateIconIfIdentifierMatches(with newModel: BreweryData?) {
        guard let newModel = newModel, model?.identifier == newModel.identifier
        else { return }
        
        self.model = newModel
        iconView.setup(name: model?.name, image: model?.logo?.image)
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
        iconView.setup(name: model?.name, image: model?.logo?.image)
        addSubview(iconView)
        iconView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(Constants.defaultSpacing)
            make.size.equalTo(Constants.iconSize)
        }
    }
    
    private func buildTitle() {
        titleLabel.text = model?.name
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconView.snp.trailing).offset(Constants.defaultSpacing)
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
            make.leading.equalTo(iconView.snp.trailing).offset(Constants.defaultSpacing)
            make.bottom.equalToSuperview().inset(Constants.defaultSpacing)
            make.height.equalTo(Constants.descriptionHeight)
            make.trailing.equalTo(ratingView.snp.leading)
        }
    }
}
