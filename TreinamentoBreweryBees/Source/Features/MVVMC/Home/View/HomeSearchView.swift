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
        static let mainViewColor: UIColor = .yellow
        static let searchBarRadius: CGFloat = 2
        static let spacingSides: CGFloat = .measurement(.small)
        static let spacingTop: CGFloat = .measurement(.large)
        static let spacingElements: CGFloat = .measurement(.big)
        static let titleColor: UIColor = .black
        static let titleHeight: CGFloat = 18
        static let titleNumberOfLines: Int = 2
        static let searchDescriptionColor: UIColor = .black
        static let searchDescriptionHeight: CGFloat = .measurement(.initialMedium)
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
        label.numberOfLines = Constants.titleNumberOfLines
        return label
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
        self.backgroundColor = .green
        self.addSubview(backgroundView)
        let screenWidth = (UIScreen.main.bounds.width) + 240
        backgroundView.snp.makeConstraints {
            $0.height.equalTo(screenWidth)
            $0.leading.equalToSuperview().inset(-120)
            $0.trailing.equalToSuperview().inset(-120)
            $0.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        backgroundView.layer.cornerRadius = screenWidth / 2
    }
    
    private func buildTitle() {
        titleLabel.text = model?.titleText
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Constants.spacingTop)
            $0.height.equalTo(50)
            $0.leading.trailing.equalToSuperview().inset(Constants.spacingSides)
        }
    }
    
    private func buildSearchBar() {
        self.addSubview(searchBar)
        searchBar.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.spacingElements)
            $0.height.equalTo(40)
            $0.leading.trailing.equalToSuperview().inset(Constants.spacingSides)
            $0.bottom.lessThanOrEqualToSuperview()
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
