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
        static let mainThemeColor = UIColor(asset: BreweryBeesAssets.Colors.beesThemeColor)
        static let backViewColor = UIColor(asset: BreweryBeesAssets.Colors.beesSoftSilverColor)
        static let navigationBarColor: UIColor = .black
        static let searchViewHeight: CGFloat = 240
        static let defaultSpacing: CGFloat = .measurement(.small)
        static let errorBottomSpacing: CGFloat = 50
        static let cirqueSpacing: CGFloat =  120
        static let valueDivisor: Int = 2
        static let defaultAnimationTime: CGFloat = 0.4
        static let defaultModalHeight: CGFloat = 420.0
        static let detailsViewIsModal: Bool = true
        static let detailsViewTopSpacing: CGFloat = .measurement(.large)
    }
    
    private enum Images {
        static let magnifyingGlass = UIImage(systemName: "magnifyingglass")
        static let circleMenu = UIImage(asset: BreweryBeesAssets.Icons.beesCircleMenuIcon)
        static let beerYellow = UIImage(asset: BreweryBeesAssets.Icons.beesBeerYellowIcon)
        static let arrowLeft = UIImage(asset: BreweryBeesAssets.Icons.beesArrowLeftIcon)
    }
    
    // MARK: - Properties
    
    private lazy var backgroundGrayView: UIView = {
        let backgroundView = UIView()
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.backgroundColor = Constants.backViewColor
        backgroundView.clipsToBounds = true
        return backgroundView
    }()
    
    private lazy var topCircleView: UIView = {
        let backgroundView = UIView()
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.backgroundColor = Constants.mainThemeColor
        backgroundView.layer.masksToBounds = false
        return backgroundView
    }()
    
    private lazy var unfocusedView: UIView = {
        .getUnfocusedView(isUserInteractionEnabled: true)
    }()
    
    private var evaluateModal: HomeModalView?
    private var detailsView: HomePopupDetailsView?
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
        
        evaluateModal = nil
        detailsView = nil
        screenError = nil
        searchView = nil
        resultView = nil
        viewModel = nil
    }
    
    // MARK: - Private methods
    
    private func setupViews() {
        setupNavBar()
        setupBackground()
        
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
                    self.resultView?.setup(
                        with: HomeResultView.Model(breweriesList: model?.breweriesList),
                        selectCellAction: { breweryModel in
                            self.setupDetails(breweryModel: breweryModel as? BreweryData)
                        }
                    )
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
        navigationController?.navigationBar.barTintColor = Constants.navigationBarColor
        navigationController?.navigationBar.tintColor = Constants.mainThemeColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Constants.mainThemeColor]
        
        let rightIcon = UIBarButtonItem(image: Images.circleMenu, style: .plain, target: self, action: #selector(menuOptionTapped))
        navigationItem.rightBarButtonItem = rightIcon
        
        setupNavHome()
    }
    
    private func setupNavHome() {
        navigationItem.title?.removeAll()
        
        let leftIcon = UIBarButtonItem(image: Images.beerYellow, style: .plain, target: self, action: #selector(beerOptionTapped))
        navigationItem.leftBarButtonItem = leftIcon
    }
    
    private func setupNavDetails() {
        navigationItem.title = TreinamentoBreweryBeesLocalizable.homeNavigationTitle.localized
        
        let leftIcon = UIBarButtonItem(image: Images.arrowLeft, style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = leftIcon
    }
    
    @objc
    private func beerOptionTapped() {
        //Do something
    }
    
    @objc
    private func menuOptionTapped() {
        //Do something
    }
    
    @objc
    private func backButtonTapped() {
        detailsView?.removeFromSuperview()
        detailsView = nil
        setupNavHome()
    }
}

// MARK: - Setup Background Views

extension HomeViewController {
    private func setupBackground() {
        view.addSubview(backgroundGrayView)
        backgroundGrayView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        backgroundGrayView.addSubview(topCircleView)
        
        let screenWidth = (UIScreen.main.bounds.width) + (Constants.cirqueSpacing * CGFloat(Constants.valueDivisor))
        
        topCircleView.snp.makeConstraints { make in
            make.height.equalTo(screenWidth)
            make.leading.equalToSuperview().inset(-Constants.cirqueSpacing)
            make.trailing.equalToSuperview().inset(-Constants.cirqueSpacing)
            make.bottom.equalTo(backgroundGrayView.snp.top).inset(Constants.searchViewHeight)
            make.centerX.equalToSuperview()
        }
        
        topCircleView.layer.cornerRadius = screenWidth / CGFloat(Constants.valueDivisor)
    }
}

// MARK: - Setup Views

extension HomeViewController {
    private func setupSearch() {
        guard let searchView = searchView else { return }
        
        backgroundGrayView.addSubview(searchView)
        searchView.snp.makeConstraints { make in
            make.height.equalTo(Constants.searchViewHeight)
            make.top.leading.trailing.equalToSuperview()
        }
    }
    
    private func setupResult() {
        guard let resultView = resultView, let searchViewBottom = searchView?.snp.bottom
        else { return }
        
        backgroundGrayView.addSubview(resultView)
        resultView.snp.makeConstraints { make in
            make.top.equalTo(searchViewBottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setupError() {
        guard let screenError = screenError else { return }
        backgroundGrayView.addSubview(screenError)
        screenError.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Constants.defaultSpacing)
            $0.leading.trailing.equalToSuperview().inset(Constants.defaultSpacing)
            $0.bottom.equalToSuperview().inset(Constants.errorBottomSpacing)
        }
    }
    
    private func setupDetails(breweryModel: BreweryData?) {
        viewModel?.prepareNextFlow(data: breweryModel, completion: { [weak self] detailsModel in
            guard let self = self else { return }
            detailsView = HomePopupDetailsView()
            detailsView?.setup(with: detailsModel, isModal: Constants.detailsViewIsModal)
        }, showEvaluateModal: { [weak self] in
            self?.showEvaluateModal(breweryModel: breweryModel)
        })
        
        guard let detailsView = detailsView else { return }
        
        backgroundGrayView.addSubview(detailsView)
        setupNavDetails()
        
        guard Constants.detailsViewIsModal else { return }
        
        UIView.transition(with: self.backgroundGrayView, duration: Constants.defaultAnimationTime, options: .layoutSubviews, animations: {
            detailsView.snp.makeConstraints { make in
                if Constants.detailsViewIsModal {
                    make.top.equalToSuperview().offset(Constants.detailsViewTopSpacing)
                    make.centerX.equalToSuperview()
                } else {
                    make.edges.equalToSuperview()
                }
            }
            self.backgroundGrayView.layoutIfNeeded()
        })
    }
    
    private func showEvaluateModal(breweryModel: BreweryData?) {
        let dismissAction: ActionHandler = { [weak self] in
            self?.dismissEvaluateModal()
        }
        
        let resultModalAction: VerifyHandler = { [weak self] state in
            self?.evaluateModal?.setup(
                type: state ? .ratingSuccess : .ratingFailed,
                dismissAction: dismissAction
            )
        }
        
        let evaluateAction: StringsActionHandler = { [weak self] values in
            guard let id = values.first,
                  let newEvaluation = values.last
            else { return }
            self?.viewModel?.updateBreweryEvaluation(
                id: id,
                newEvaluation: newEvaluation,
                completion: resultModalAction
            )
        }
        
        let verifyEmailAction: VerifyStringHandler = { [weak self] value in
            self?.viewModel?.verifyEmail(email: value) ?? false
        }
        
        let popupModel = HomeModalView.Model(
            breweryData: breweryModel,
            evaluateAction: evaluateAction,
            verifyEmail: verifyEmailAction,
            hasDefaultHeight: true
        )
        
        evaluateModal = HomeModalView(type: .rating(model: popupModel), dismissAction: dismissAction)
        guard let evaluateModal = evaluateModal else { return }
        
        view.addSubview(unfocusedView)
        unfocusedView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        unfocusedView.addSubview(evaluateModal)
        evaluateModal.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(unfocusedView.snp.bottom)
        }
        
        view.layoutIfNeeded()
        
        UIView.animate(withDuration: Constants.defaultAnimationTime) {
            evaluateModal.snp.remakeConstraints { make in
                make.leading.trailing.bottom.equalToSuperview()
                make.height.equalTo(Constants.defaultModalHeight)
            }
            self.view.layoutIfNeeded()
        }
    }
    
    private func dismissEvaluateModal() {
        evaluateModal?.removeFromSuperview()
        evaluateModal = nil
        unfocusedView.removeFromSuperview()
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
