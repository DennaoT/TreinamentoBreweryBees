//
//  HomeViewController.swift
//  TreinamentoBreweryBees
//
//  Created by Dennis Torres on 02/04/24.
//

import UIKit

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

    // MARK: - Instantiate
    
    /*public static func instantiate(viewModel: HomeViewModelProtocol) -> HomeViewController {
        let controller = HomeViewController()
        controller.viewModel = viewModel
        return controller
    }*/
    
    // MARK: - Life Cycles/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupView()
    }
    
    // MARK: - Private methods
    
    private func setupView() {
        view.backgroundColor = Constants.mainViewColor
        
        title = "\(TreinamentoBreweryBeesLocalizable.userName.localized): Dennis"
    }
}
