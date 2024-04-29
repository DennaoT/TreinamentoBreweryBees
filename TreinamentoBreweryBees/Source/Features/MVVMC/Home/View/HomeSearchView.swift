//
//  HomeSearchView.swift
//  TreinamentoBreweryBees
//
//  Created by Dennis Torres on 02/04/24.
//

import UIKit
import SnapKit

// MARK: - Typealias

typealias HomeSearchBarDelegate = UISearchBarDelegate & UIGestureRecognizerDelegate

class HomeSearchView: UIView {
    
    // MARK: - Model
    
    struct Model {
        var titleText: String
        var searchDescription: String?
        var hasSearchIcon: Bool
        var enableVoiceSearch: Bool
        
        public init(
            titleText: String = "Bem vindo,\nEncontre as melhores cervejarias",
            searchDescription: String? = "Buscar local",
            hasSearchIcon: Bool = true,
            enableVoiceSearch: Bool = false
        ) {
            self.titleText = titleText
            self.searchDescription = searchDescription
            self.hasSearchIcon = hasSearchIcon
            self.enableVoiceSearch = enableVoiceSearch
        }
    }
    
    // MARK: - Enum
    
    private enum Constants {
        static let shadowColor: UIColor = .lightGray.withAlphaComponent(0.3)
        static let backViewColor = UIColor(asset: BreweryBeesAssets.Colors.beesSoftSilverColor)
        static let mainViewColor = UIColor(asset: BreweryBeesAssets.Colors.beesThemeColor)
        static let searchBarRadius: CGFloat = 2
        static let shadowSearchBarRadius: CGFloat = .measurement(.nano)
        static let spacingSides: CGFloat = .measurement(.small)
        static let spacingTop: CGFloat = .measurement(.large)
        static let spacingElements: CGFloat = .measurement(.big)
        static let titleColor: UIColor = .black
        static let titleHeight: CGFloat = 18
        static let titleContainerHeight: CGFloat = 50
        static let valueTwo: Int = 2
        static let searchDescriptionColor: UIColor = .black
        static let searchDescriptionHeight: CGFloat = .measurement(.initialMedium)
        static let searchContainerHeight: CGFloat = .measurement(.xBig)
        static let cirqueSpacing: CGFloat =  120
    }
    
    // MARK: - Views
    
    private lazy var backgroundView: UIView = {
        let backgroundView = UIView()
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.backgroundColor = Constants.mainViewColor
        backgroundView.layer.masksToBounds = false
        return backgroundView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Constants.titleColor
        label.font = .boldSystemFont(ofSize: Constants.titleHeight)
        label.textAlignment = .left
        label.contentMode = .scaleAspectFit
        label.numberOfLines = Constants.valueTwo
        return label
    }()
    
    private lazy var searchBarShadow: UIView = {
        let backgroundView = UIView()
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.backgroundColor = Constants.shadowColor
        backgroundView.layer.cornerRadius = Constants.shadowSearchBarRadius
        return backgroundView
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.barTintColor = Constants.mainViewColor
        searchBar.backgroundColor = .white
        searchBar.layer.cornerRadius = Constants.searchBarRadius
        searchBar.backgroundImage = UIImage()
        searchBar.clipsToBounds = true
        searchBar.searchTextField.backgroundColor = .white
        return searchBar
    }()
    
    // MARK: - Properties
    
    private weak var delegate: HomeSearchBarDelegate?
    private var model: HomeSearchView.Model?
    
    // MARK: - Public methods
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with model: HomeSearchView.Model?, delegate: HomeSearchBarDelegate?) {
        guard let model = model,
              let delegate = delegate
        else { return }
        
        self.model = model
        self.delegate = delegate
        
        buildComponents()
    }
    
    // MARK: - Private methods
    
    private func buildComponents() {
        buildMain()
        buildTitle()
        buildSearchBar()
    }
    
    private func buildMain() {
        self.clipsToBounds = true
        self.backgroundColor = Constants.backViewColor
        self.addSubview(backgroundView)
        
        let screenWidth = (UIScreen.main.bounds.width) + (Constants.cirqueSpacing * CGFloat(Constants.valueTwo))
        
        backgroundView.snp.makeConstraints {
            $0.height.equalTo(screenWidth)
            $0.leading.equalToSuperview().inset(-Constants.cirqueSpacing)
            $0.trailing.equalToSuperview().inset(-Constants.cirqueSpacing)
            $0.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        backgroundView.layer.cornerRadius = screenWidth / CGFloat(Constants.valueTwo)
    }
    
    private func buildTitle() {
        titleLabel.text = model?.titleText
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Constants.spacingTop)
            $0.height.equalTo(Constants.titleContainerHeight)
            $0.leading.trailing.equalToSuperview().inset(Constants.spacingSides)
        }
    }
    
    private func buildSearchBar() {
        self.addSubview(searchBarShadow)
        searchBarShadow.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.spacingElements)
            $0.height.equalTo(Constants.searchContainerHeight)
            $0.leading.trailing.equalToSuperview().inset(Constants.spacingSides)
            $0.bottom.lessThanOrEqualToSuperview()
        }
        
        searchBarShadow.addSubview(searchBar)
        searchBar.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(Constants.valueTwo)
        }
        
        searchBar.delegate = delegate
        searchBar.placeholder = model?.searchDescription
    }
    
    private func setupSearchBarResign() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.delegate = delegate
        searchBar.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        searchBar.resignFirstResponder()
    }
}
