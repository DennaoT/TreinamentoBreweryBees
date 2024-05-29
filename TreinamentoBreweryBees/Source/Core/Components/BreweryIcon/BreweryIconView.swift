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
        static let mainViewColor: UIColor = .white
        static let defaultSpacing: CGFloat = .measurement(.small)
        static let iconSize: CGFloat = .measurement(.big)
        static let defaultIconViewColor: UIColor = .init(hex: "#FFC366")
        static let defaultIconLabelColor: UIColor = .init(hex: "#8A7251")
        static let defaultIconViewRadiusDivisor: CGFloat = 2
        static let defaultIconLabelMultiplicand: CGFloat = 0.8
        static let unknownLogo: String = "?"
    }
    
    // MARK: - Views
    
    private lazy var defaultIconView: UIView = {
        let backgroundView = UIView()
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.backgroundColor = Constants.defaultIconViewColor
        backgroundView.layer.cornerRadius = Constants.iconSize/Constants.defaultIconViewRadiusDivisor
        backgroundView.layer.masksToBounds = true
        return backgroundView
    }()
    
    private lazy var defaultIconLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Constants.defaultIconLabelColor
        label.font = .boldSystemFont(ofSize: Constants.iconSize * Constants.defaultIconLabelMultiplicand)
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
    
    private var image: UIImage?
    private var breweryName: String?
    
    // MARK: - Public methods
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(image: UIImage?, breweryName: String?) {
        self.image = image
        self.breweryName = breweryName
        
        buildComponents()
    }
    
    // MARK: - Private methods
    
    private func buildComponents() {
        guard let image = image, let breweryName = breweryName else { return }
        
        backgroundColor = Constants.mainViewColor
        
        addSubview(defaultIconView)
        defaultIconView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(Constants.defaultSpacing)
            make.size.equalTo(Constants.iconSize)
        }
        
        buildImage()
    }
    
    private func buildImage() {
//        UIImage.loadFromURL(urlString: model?.logo) { [weak self] image in
//            guard let self = self else { return }
//            if let image = image {
//                self.iconImage.image = image
//                self.defaultIconView.addSubview(self.iconImage)
//                self.iconImage.snp.makeConstraints { make in
//                    make.center.equalToSuperview()
//                    make.size.equalToSuperview()
//                }
//            } else {
//                if let firstChar = self.model?.name.first {
//                    self.defaultIconLabel.text = String(firstChar.uppercased())
//                }
//                
//                self.defaultIconView.addSubview(self.defaultIconLabel)
//                self.defaultIconLabel.snp.makeConstraints { make in
//                    make.center.equalToSuperview()
//                }
//            }
//        }
    }
}
