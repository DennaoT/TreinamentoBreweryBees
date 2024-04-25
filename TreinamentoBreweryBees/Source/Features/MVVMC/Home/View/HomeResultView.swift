//
//  HomeResultView.swift
//  TreinamentoBreweryBees
//
//  Created by Dennis Torres on 15/04/24.
//

import UIKit
import SnapKit

class HomeResultView: UIView {
    
    // MARK: - Model
    
    struct Model {
        var resultFlowType: ResultFlowType
        var breweriesList: [BreweryData]?
        
        public init(
            resultFlowType: ResultFlowType = .verticalCarousel,
            breweriesList: [BreweryData]?
        ) {
            self.resultFlowType = resultFlowType
            self.breweriesList = breweriesList
        }
    }
    
    // MARK: - Enums
    
    enum ResultFlowType {
        case verticalCarousel
        case controlPage
    }
    
    private enum ResultScreenType {
        case defaultResults
        case noDataFound
        case emptySearch
    }
    
    private enum Constants {
        static let mainViewColor: UIColor = .white
        static let titleColor: UIColor = .black
        static let titleHeight: CGFloat = 18
        static let descriptionColor: UIColor = .black
        static let descriptionHeight: CGFloat = 18
    }
    
    // MARK: - Views
    
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
        label.font = .boldSystemFont(ofSize: Constants.titleHeight)
        label.textAlignment = .left
        label.contentMode = .scaleAspectFit
        return label
    }()
    
    // MARK: - Properties
    
    private var resultScreen: ResultScreenType = .emptySearch
    private var model: HomeResultView.Model?
    
    // MARK: - Public methods
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with model: HomeResultView.Model?) {
        guard let model = model else { return }
        
        self.model = model
        
        buildComponents()
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
}
