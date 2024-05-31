//
//  BreweryIconView.swift
//  TreinamentoBreweryBees
//
//  Created by Dennis Torres on 29/05/24.
//

import UIKit
import SnapKit

class BreweryIconView: UIView {
    
    // MARK: - Enums
    
    private enum Constants {
        static let defaultSpacing: CGFloat = .measurement(.small)
        static let defaultIconSize: CGFloat = .measurement(.big)
        static let defaultIconViewColor: UIColor = .init(hex: "#FFC366")
        static let defaultIconLabelColor: UIColor = .init(hex: "#8A7251")
        static let defaultIconViewRadiusDivisor: CGFloat = 2
        static let defaultIconLabelMultiplicand: CGFloat = 0.8
        static let unknownLogo: String = "?"
    }
    
    // MARK: - Views
    
    private lazy var defaultIconLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Constants.defaultIconLabelColor
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
    
    // MARK: - Properties
    
    private var size: CGFloat = .zero
    private var breweryImage: UIImage?
    private var breweryName: String?
    
    // MARK: - Public methods
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        breweryImage = nil
        breweryName = nil
    }
    
    func setup(name: String?, image: UIImage?, iconSize: CGFloat? = nil) {
        self.breweryName = name
        self.breweryImage = image
        
        if let iconSize = iconSize, iconSize > Constants.defaultIconSize {
            self.size = iconSize
        } else {
            self.size = Constants.defaultIconSize
        }
        
        buildComponents()
    }
    
    // MARK: - Private methods
    
    private func buildComponents() {
        backgroundColor = Constants.defaultIconViewColor
        layer.cornerRadius = size/Constants.defaultIconViewRadiusDivisor
        layer.masksToBounds = true
        
        removeSubviews()
        
        breweryImage != nil ? buildFromImage() : buildDefault()
    }
    
    private func buildDefault() {
        defaultIconLabel.text = breweryName?.filterString().first?.uppercased() ?? Constants.unknownLogo
        defaultIconLabel.font = .boldSystemFont(ofSize: size * Constants.defaultIconLabelMultiplicand)
        
        addSubview(defaultIconLabel)
        defaultIconLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func buildFromImage() {
        guard let breweryImage = breweryImage else { return }
        
        iconImage.image = breweryImage
        addSubview(iconImage)
        iconImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalToSuperview()
        }
    }
}
