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
        static let navigationBarElementsColor = UIColor(asset: BreweryBeesAssets.Colors.beesThemeColor)
        static let navigationBarColor: UIColor = .black
        static let searchViewHeight: CGFloat = 240
        static let defaultSpacing: CGFloat = .measurement(.small)
        static let errorBottomSpacing: CGFloat = 50
    }
    
    private enum Images {
        static let magnifyingGlass = UIImage(systemName: "magnifyingglass")
        static let circleMenu = UIImage(asset: BreweryBeesAssets.Icons.beesCircleMenuIcon)
        static let beerYellow = UIImage(asset: BreweryBeesAssets.Icons.beesBeerYellowIcon)
        static let arrowLeft = UIImage(asset: BreweryBeesAssets.Icons.beesArrowLeftIcon)
    }
    
    // MARK: - Properties
    
    private var searchView: HomeSearchView?
    private var resultView: HomeResultView?
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
        resultView = HomeResultView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        fetchViewModel()
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        
        bindElements()
        bindCellsImagesIfNeeded()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        screenError = nil
        searchView = nil
        resultView = nil
        viewModel = nil
    }
    
    // MARK: - Private methods
    
    private func setupViews() {
        setupNavBar()
        setupSearch()
        setupResult()
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
                    self.searchView?.setup(delegate: self)
                    self.resultView?.setup(with: HomeResultView.Model(breweriesList: model?.breweriesList))
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
    
    private func bindCellsImagesIfNeeded() {
        viewModel?.updateCellsImagesIfNeeded { [weak self] imagesToUpdate in
            guard !imagesToUpdate.isEmpty, let self = self else { return }
            self.resultView?.setupCellImages(updatedImages: imagesToUpdate)
        }
    }
}

// MARK: - Setup Navigation Bar

extension HomeViewController {
    private func setupNavBar() {
        navigationItem.title = TreinamentoBreweryBeesLocalizable.homeNavigationTitle.localized
        
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
    private func setupSearch() {
        guard let searchView = searchView else { return }
        
        view.addSubview(searchView)
        searchView.snp.makeConstraints { make in
            make.height.equalTo(Constants.searchViewHeight)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    private func setupResult() {
        guard let resultView = resultView, let searchViewBottom = searchView?.snp.bottom
        else { return }
        
        view.addSubview(resultView)
        resultView.snp.makeConstraints { make in
            make.top.equalTo(searchViewBottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setupError() {
        guard let screenError = screenError else { return }
        view.addSubview(screenError)
        screenError.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(Constants.defaultSpacing)
            $0.leading.trailing.equalToSuperview().inset(Constants.defaultSpacing)
            $0.bottom.equalToSuperview().inset(Constants.errorBottomSpacing)
        }
    }
}

// MARK: - Loading

extension HomeViewController {
    private func startLoading() {
        view.backgroundColor = .red
    }
    
    private func stopLoading() {
        view.backgroundColor = .black
    }
}

// MARK: - SearchBarDelegate

extension HomeViewController: HomeSearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        resultView?.update(filter: searchBar.text)
    }
}
