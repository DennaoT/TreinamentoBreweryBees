//
//  HomeViewController.swift
//  TreinamentoBreweryBees
//
//  Created by Dennis Torres on 02/04/24.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    // MARK: - Enums
    
    private enum Constants {
        static let navigationBarElementsColor: UIColor = .yellow
        static let navigationBarColor: UIColor = .black
        static let mainViewColor: UIColor = .white
        static let titleHeight: CGFloat = 28
        static let defaultSpacing: CGFloat = 16
    }
    
    private enum Images {
        static let magnifyingGlass = UIImage(systemName: "magnifyingglass")
        static let circleMenu = UIImage(asset: BreweryBeesAssets.beesCircleMenuIcon)
        static let beerYellow = UIImage(asset: BreweryBeesAssets.beesBeerYellowIcon)
        static let arrowLeft = UIImage(asset: BreweryBeesAssets.beesArrowLeftIcon)
    }
    
    // MARK: - Views
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = Constants.defaultSpacing
        stackView.backgroundColor = Constants.mainViewColor
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: Constants.titleHeight)
        label.textAlignment = .center
        label.contentMode = .scaleAspectFit
        return label
    }()
    
    // MARK: - Properties
    
    private var searchView: HomeSearchView?
    private var screenError: GenericErrorView?
    private var viewModel: HomeViewModelProtocol?

    // MARK: - Instantiate
    
    public static func instantiate(viewModel: HomeViewModelProtocol) -> HomeViewController {
        let controller = HomeViewController()
        controller.viewModel = viewModel
        return controller
    }
    
    // MARK: - Life Cycles
    
    override func loadView() {
        super.loadView()
        
        screenError = GenericErrorView()
        searchView = HomeSearchView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        bindElements()
        fetchViewModel()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        screenError = nil
        searchView = nil
        viewModel = nil
    }
    
    // MARK: - Private methods
    
    private func setupViews() {
        setupNavBar()
        setupMainView()
        setupTopBar()
        setupSearch()
        setupList()
        setupError()
    }
    
    private func fetchViewModel() {
        viewModel?.fetchHomeData()
    }
    
    private func bindElements() {
        viewModel?.breweryModel.bind { [weak self] status in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.screenError?.isHidden = true
                switch status {
                case .success(let model):
                    guard let textModel: String? = model?.breweriesList.first?.website else { return }
                    self.searchView?.setup(with: HomeSearchView.Model(), delegate: self)
                    self.stopLoading()
                case .error(let model):
                    self.screenError?.setup(with: model)
                    self.screenError?.isHidden = false
                    self.stopLoading()
                case .loading:
                    self.startLoading()
                }
            }
        }
    }
}

// MARK: - Setup Navigation Bar

extension HomeViewController {
    private func setupNavBar() {
        navigationItem.title = "Detalhes da cervejaria"
        
        navigationController?.navigationBar.barTintColor = Constants.navigationBarColor
        navigationController?.navigationBar.tintColor = Constants.navigationBarElementsColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Constants.navigationBarElementsColor]
        
        let optionBeer = UIBarButtonItem(image: Images.beerYellow, style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = optionBeer
        
        let optionMenuList = UIBarButtonItem(image: Images.circleMenu, style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.rightBarButtonItem = optionMenuList
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Setup Views

extension HomeViewController {
    private func setupMainView() {
//        view.addSubview(mainStackView)
//        mainStackView.snp.makeConstraints {
//            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
//            $0.leading.trailing.bottom.equalToSuperview()
//        }
    }
    
    private func setupTopBar() {
//        mainStackView.addArrangedSubview(titleLabel)
//        titleLabel.snp.makeConstraints {
//            $0.height.equalTo(Constants.titleHeight)
//        }
    }
    
    private func setupSearch() {
        guard let searchView = searchView else { return }
        
        view.addSubview(searchView)
        searchView.snp.makeConstraints {
            $0.height.equalTo(280)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    private func setupList() {
        
    }
    
    private func setupError() {
        guard let screenError = screenError else { return }
        view.addSubview(screenError)
        screenError.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(Constants.defaultSpacing)
            $0.leading.trailing.equalToSuperview().inset(Constants.defaultSpacing)
            $0.bottom.equalToSuperview().inset(50)
        }
    }
}

// MARK: - Loading

extension HomeViewController {
    private func startLoading() {
        mainStackView.backgroundColor = .red
    }
    
    private func stopLoading() {
        mainStackView.backgroundColor = Constants.mainViewColor
    }
}

// MARK: - Loading

extension HomeViewController: HomeSearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if let clearButton = searchBar.value(forKey: "clearButton") as? UIButton {
//            clearButton.isHidden = searchBar.text?.isEmpty ?? true
//        }
    }
    
//    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
//        searchBar.resignFirstResponder()
//        return true
//    }
//    
//    func searchBarResultsListButtonClicked(_ searchBar: UISearchBar) {
//        searchBar.resignFirstResponder()
//    }
//    
//    func searchBar(_ searchBar: UISearchBar, searchText: String) {
//        searchBar.resignFirstResponder()
//    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        guard let touchedView = touch.view else { return true }
        return !(touchedView is UISearchBar)
    }
}
