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
        static let magnifyingGlass: UIImage? = UIImage(systemName: "magnifyingglass")
        static let circleMenu: UIImage? = UIImage(asset: BreweryBeesAssets.beesCircleMenuIcon)
        static let beerYellow: UIImage? = UIImage(asset: BreweryBeesAssets.beesBeerYellowIcon)
        static let arrowLeft: UIImage? = UIImage(asset: BreweryBeesAssets.beesArrowLeftIcon)
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
        viewModel = nil
    }
    
    // MARK: - Private methods
    
    private func setupViews() {
        setupNavBar()
        setupMainView()
        setupTopBar()
        setupSearch()
        setupList()
    }
    
    private func fetchViewModel() {
        viewModel?.fetchHomeData()
    }
    
    private func bindElements() {
        viewModel?.breweryModel.bind { [weak self] status in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch status {
                case .success(let model):
                    guard let textModel = model?.breweriesList.first?.name else { return }
                    self.titleLabel.text = "\(textModel)"
                    self.stopLoading()
                case .error(let model):
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
        view.addSubview(mainStackView)
        mainStackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setupTopBar() {
        titleLabel.text = "TESTEEEEE"
        mainStackView.addArrangedSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(Constants.titleHeight)
        }
    }
    
    private func setupSearch() {
        
    }
    
    private func setupList() {
        
    }
    
    private func setupError() {
        
    }
}

// MARK: - Loading

extension HomeViewController {
    private func startLoading() {
        
    }
    
    private func stopLoading() {
        
    }
}
