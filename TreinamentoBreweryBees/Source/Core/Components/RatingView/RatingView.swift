//
//  RatingView.swift
//  TreinamentoBreweryBees
//
//  Created by Dennis Torres on 24/04/24.
//

import UIKit
import SnapKit

class RatingView: UIView {
    
    // MARK: - Enums
    
    enum ScreenType<V> {
        case toEvaluate(evaluateAction: StringActionHandler? = nil)
        case seeReview(V?, showLeftNumber: Bool = false)
    }
    
    private enum Constants {
        static let mainViewColor: UIColor = .white
        static let titleColor: UIColor = .black
        static let titleHeight: CGFloat = 18
        static let descriptionColor: UIColor = .black
        static let descriptionHeight: CGFloat = 18
    }
    
    // MARK: - Views
    
    private lazy var numberText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Constants.titleColor
        label.font = .boldSystemFont(ofSize: Constants.titleHeight)
        label.textAlignment = .left
        label.contentMode = .scaleAspectFit
        return label
    }()
    
    private lazy var firstStar: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var secondStar: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var thirdStar: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var fourthStar: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var fifthStar: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Properties
    
    private var evaluateAction: StringActionHandler?
    private var valuationValue: CGFloat?
    private var showLeftNumber: Bool = false
    
    // MARK: - Public methods
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(_ screenType: ScreenType<Any>) {
        buildComponents()
        
        switch screenType {
        case .toEvaluate(let evaluateAction):
            self.evaluateAction = evaluateAction
            
            setupToEvaluate()
        case .seeReview(let valuation, let showLeftNumber):
            guard let valuation = valuation as? CGFloat else { return }
            
            self.valuationValue = valuation
            self.showLeftNumber = showLeftNumber
            
            setupSeeReview()
        }
    }
    
    // MARK: - Private methods
    
    private func buildComponents() {
        buildMain()
        buildTitle()
        buildSearchBar()
    }
    
    private func buildMain() {
        //Lalalala
    }
    
    private func buildTitle() {
        //Lalalala
    }
    
    private func buildSearchBar() {
        //Lalalala
    }
    
    // MARK: - Setup screen type
    
    private func setupToEvaluate() {
        //Lalalala
    }
    
    private func setupSeeReview() {
        guard let valuationValue = valuationValue else { return }
        
        firstStar.image = .getRatedStar(valuationValue - 1)
        secondStar.image = .getRatedStar(valuationValue - 2)
        thirdStar.image = .getRatedStar(valuationValue - 3)
        fourthStar.image = .getRatedStar(valuationValue - 4)
        fifthStar.image = .getRatedStar(valuationValue - 5)
    }
}

// MARK: - UIImage Rated Star

extension UIImage {
    static func getRatedStar(_ value: CGFloat) -> UIImage {
        let imageAsset: ImageAsset
        
        switch value {
        case ...0:
            imageAsset = BreweryBeesAssets.Icons.beesStarOutlinedIcon
        case 1.0...:
            imageAsset = BreweryBeesAssets.Icons.beesStartFilledIcon
        default:
            imageAsset = BreweryBeesAssets.Icons.beesStarOutlinedIcon
        }
        
        return UIImage(asset: imageAsset) ?? UIImage()
    }
}

