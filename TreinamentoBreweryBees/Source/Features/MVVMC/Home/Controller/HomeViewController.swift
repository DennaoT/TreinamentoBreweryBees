//
//  HomeViewController.swift
//  TreinamentoBreweryBees
//
//  Created by Dennis Torres on 02/04/24.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let mainViewColor: UIColor = .white
        static let titleHeight: CGFloat = 28
        static let defaultSpacing: CGFloat = 16
    }
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.spacing = Constants.defaultSpacing
        stackView.backgroundColor = .white
        return stackView
    }()
    
    private lazy var imagemAna: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(asset: BreweryBeesAssets.beesCircleMenuIcon)
        return img
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
            switch status {
            case .success(let model):
                self.stopLoading()
            case .error(let model):
                self.stopLoading()
            case .loading:
                self.startLoading()
            }
        }
    }
}

// MARK: - Setup Views

extension HomeViewController {
    private func setupMainView() {
        view.backgroundColor = Constants.mainViewColor
        
        title = "\(TreinamentoBreweryBeesLocalizable.userName.localized): Dennis"
    }
    
    private func setupTopBar() {
        
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
