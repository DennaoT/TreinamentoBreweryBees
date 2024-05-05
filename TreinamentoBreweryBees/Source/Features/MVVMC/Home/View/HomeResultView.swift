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
        static let mainViewColor = UIColor(asset: BreweryBeesAssets.Colors.beesSoftSilverColor)
        static let titleColor: UIColor = .black
        static let titleHeight: CGFloat = 18
        static let descriptionColor: UIColor = .init(hex: "#595959")
        static let descriptionHeight: CGFloat = 18
        static let defaultSpacing: CGFloat = .measurement(.small)
    }
    
    // MARK: - Views
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Constants.titleColor
        label.font = .boldSystemFont(ofSize: Constants.titleHeight)
        label.textAlignment = .center
        label.contentMode = .scaleAspectFit
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Constants.titleColor
        label.font = .boldSystemFont(ofSize: Constants.titleHeight)
        label.textAlignment = .center
        label.contentMode = .scaleAspectFit
        return label
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = Constants.defaultSpacing
        return stackView
    }()
    
    private lazy var controlPageStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = Constants.defaultSpacing
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    // MARK: - Properties
    
    private var breweriesCells: [BreweryCellView] = []
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
    
    func update(filter: String?) {
        guard let breweriesList = model?.breweriesList else { return }
        
        filterBreweries(filter)
        updateMain()
    }
    
    // MARK: - Private methods
    
    private func buildComponents() {
        guard let flowType = model?.resultFlowType else { return }
        
        backgroundColor = Constants.mainViewColor
        
        titleLabel.text = TreinamentoBreweryBeesLocalizable.homeResultsTitle_NoDataFound.localized
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(50)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }
        
        descriptionLabel.text = TreinamentoBreweryBeesLocalizable.homeResultsDescription_TryAgain.localized
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(16)
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalTo(titleLabel.snp.trailing)
            make.height.equalTo(44)
        }
        
        addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).inset(16)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(flowType == .verticalCarousel ? .zero : 50)
        }
        
        scrollView.addSubview(mainStackView)
        mainStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        mainStackView.axis = flowType == .verticalCarousel ? .vertical : .horizontal
        
        buildStackElements()
        
        shouldPresentElements()
    }
    
    private func buildStackElements() {
        guard let flowType = model?.resultFlowType,
              !breweriesCells.isEmpty
        else { return }
        
        mainStackView.removeAllArrangedSubviews()
        
        switch flowType {
        case .verticalCarousel:
            builVerticalCarousel()
        case .controlPage:
            buildControlPage()
        }
    }
    
    private func builVerticalCarousel() {
        mainStackView.addArrangedSubviews(breweriesCells)
        for brewery in breweriesCells {
            brewery.snp.makeConstraints { make in
                make.height.equalTo(60)
            }
        }
        
        //TALVEZ adicionar height à breweriesCells
    }
    
    private func buildControlPage() {
        for brewery in breweriesCells {
            // TO DO
        }
    }
    
    private func shouldPresentElements() {
        scrollView.isHidden = resultScreen != .defaultResults
        scrollView.isUserInteractionEnabled = resultScreen == .defaultResults
        mainStackView.isHidden = resultScreen != .defaultResults
        mainStackView.isUserInteractionEnabled = resultScreen == .defaultResults
        && model?.resultFlowType != .controlPage
    }
    
    // MARK: - Update
    
    private func updateMain() {
        shouldPresentElements()
        
        switch resultScreen {
        case .defaultResults:
            titleLabel.text = TreinamentoBreweryBeesLocalizable.homeResultsTitle_Success.localized
            if let breweriesList = model?.breweriesList{
                descriptionLabel.text = String(
                    format: TreinamentoBreweryBeesLocalizable.homeResultsDescription_Success.localized,
                    breweriesCells.count, breweriesList.count)
            }
            updateDefaultResults()
        case .noDataFound:
            titleLabel.text = TreinamentoBreweryBeesLocalizable.homeResultsTitle_NoDataFound.localized
            descriptionLabel.text = TreinamentoBreweryBeesLocalizable.homeResultsDescription_TryAgain.localized
            updateNoResults()
        case .emptySearch:
            titleLabel.text = TreinamentoBreweryBeesLocalizable.homeResultsTitle_EmptySearch.localized
            descriptionLabel.text = TreinamentoBreweryBeesLocalizable.homeResultsDescription_TryAgain.localized
            updateNoResults()
        }
        
        buildStackElements()
        shouldPresentElements()
    }
    
    private func updateDefaultResults() {
        titleLabel.textAlignment = .left
        descriptionLabel.textAlignment = .left
        descriptionLabel.font = .boldSystemFont(ofSize: Constants.descriptionHeight)
        
        titleLabel.snp.updateConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.height.equalTo(22)
        }
        
        descriptionLabel.snp.updateConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(8)
            make.height.equalTo(22)
        }
    }
    
    private func updateNoResults() {
        titleLabel.textAlignment = .center
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = .systemFont(ofSize: Constants.descriptionHeight)
        
        titleLabel.snp.updateConstraints { make in
            make.top.equalToSuperview().inset(50)
            make.height.equalTo(44)
        }
        
        descriptionLabel.snp.updateConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(16)
            make.height.equalTo(44)
        }
    }
    
    private func filterBreweries(_ filter: String? = nil) {
        breweriesCells.removeAll()
        
        guard let breweriesList = model?.breweriesList,
              let filter = filter,
              !(filter.filterString()).isEmpty
        else {
            resultScreen = .emptySearch
            return
        }
        
        for breweryData in breweriesList {
            let nameMatches = breweryData.name.filterString().contains(filter.filterString())
            let descriptionMatches = breweryData.description?.contains(filter.filterString()) ?? false
            let addressMatches = breweryData.address.contains(filter.filterString())
            let typeMatches = breweryData.type?.contains(filter.filterString()) ?? false
            let websiteMatches = breweryData.website.contains(filter.filterString())
            
            guard nameMatches || descriptionMatches || addressMatches || typeMatches || websiteMatches else { return }
            
            let breweryCell = BreweryCellView()
            breweryCell.setup(with: breweryData)
            breweriesCells.append(breweryCell)
        }
        
        resultScreen = !breweriesCells.isEmpty ? .defaultResults : .noDataFound
    }
}
