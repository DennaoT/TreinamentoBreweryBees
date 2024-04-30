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
        case seeReview(V?, showLeftNumber: RatingLeftNumber = .hideLeftNumber)
    }
    
    enum RatingLeftNumber {
        case hideLeftNumber
        case showLeftNumber(sizeOfNumberLabel: CGFloat)
    }
    
    private enum Constants {
        static let mainViewColor: UIColor = .white
        static let titleColor: UIColor = .black
        static let descriptionColor: UIColor = .black
        static let descriptionHeight: CGFloat = 18
        static let numOfStars: Int = 5
        static let defaultSpacing: CGFloat = 2.5
    }
    
    // MARK: - Views
    
    private lazy var numberText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Constants.titleColor
        label.textAlignment = .left
        label.contentMode = .scaleAspectFit
        return label
    }()
    
    private lazy var starsRating: [UIImageView] = {
        return (0..<Constants.numOfStars).map { _ in
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFit
            imageView.isUserInteractionEnabled = false
            return imageView
        }
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = Constants.defaultSpacing
        stackView.backgroundColor = Constants.mainViewColor
        return stackView
    }()
    
    // MARK: - Properties
    
    private var evaluateAction: StringActionHandler?
    private var valuationValue: CGFloat?
    private var showLeftNumber: RatingLeftNumber?
    
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
        addSubview(mainStackView)
        mainStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        for starView in starsRating {
            mainStackView.addSubview(starView)
        }
    }
    
    // MARK: - Setup To Evaluate - screen type
    
    private func setupToEvaluate() {
        for starImage in starsRating {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectStar(_:)))
            tapGesture.numberOfTapsRequired = 1
            starImage.isUserInteractionEnabled = true
            starImage.addGestureRecognizer(tapGesture)
        }
        
        buildLeftNumber()
    }
    
    // MARK: - Setup See Review - screen type
    
    private func setupSeeReview() {
        guard let valuationValue = valuationValue else { return }
        
        for (index, starImage) in starsRating.enumerated() {
            starImage.image = .getRatedStar(valuationValue - CGFloat(index+1))
        }
    }
}

extension RatingView {
    @objc private func selectStar(_ gesture: UITapGestureRecognizer) {
        guard let selectedStar = gesture.view as? UIImageView,
              let finalIndex = starsRating.firstIndex(of: selectedStar),
              let valuationValue = valuationValue
        else { return }
        
        for index in 0...finalIndex {
            starsRating[index].image = .getRatedStar(valuationValue)
        }
        
        if let action = evaluateAction {
            action(String(describing: valuationValue))
        }
    }
    
    private func buildLeftNumber() {
        guard case let .showLeftNumber(sizeOfNumberLabel) = showLeftNumber,
              let valuationValue = valuationValue
        else { return }
        
        numberText.font = .boldSystemFont(ofSize: sizeOfNumberLabel)
        numberText.text = String(describing: valuationValue)
        
        mainStackView.insertArrangedSubview(numberText, at: .zero)
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