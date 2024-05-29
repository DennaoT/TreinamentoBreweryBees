//
//  HomeViewModelTests.swift
//  TreinamentoBreweryBeesTests
//
//  Created by Dennis Torres on 15/05/24.
//

import XCTest
@testable import TreinamentoBreweryBees

class HomeViewModelTests: XCTestCase {
    
    var viewModel: HomeViewModel!
    var mockDelegate: MockHomeCoordinatorDelegate!
    var mockManager: MockBreweryBeesService!
    
    override func setUp() {
        super.setUp()
        mockDelegate = MockHomeCoordinatorDelegate()
        mockManager = MockBreweryBeesService()
        viewModel = HomeViewModel(delegate: mockDelegate)
    }
    
    override func tearDown() {
        viewModel = nil
        mockDelegate = nil
        mockManager = nil
        super.tearDown()
    }
    
    func testFetchHomeDataSuccess() {
        // Mock the BreweryBeesService response
        mockManager.fetchResult = .success(MockBreweryListData.breweryListData)
        
        let expectation = self.expectation(description: "Fetch home data success")
        
        viewModel.breweryModel.bind { status in
            if case .success(let data) = status {
                XCTAssertEqual(data?.breweriesList.count, 3)
                expectation.fulfill()
            }
        }
        
        viewModel.fetchHomeData()
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testFetchHomeDataFailureFirestoreError() {
        // Given
        mockManager.fetchResult = .failure(FirestoreError.notFound)
        
        // When
        viewModel.fetchHomeData()
        
        // Then
        XCTAssertEqual(viewModel.breweryModel.value, .loading)
        let expectation = XCTestExpectation(description: "Fetch Home Data Failure FirestoreError")
        
        DispatchQueue.main.async {
            if case .error(let errorModel) = self.viewModel.breweryModel.value {
                XCTAssertEqual(errorModel?.titleText, TreinamentoBreweryBeesLocalizable.errorFirestore_notFound.localized)
            } else {
                XCTFail("Expected error state")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFetchHomeDataFailureInternetError() {
        // Given
        mockManager.fetchResult = .failure(InternetError.noConnection)
        
        // When
        viewModel.fetchHomeData()
        
        // Then
        XCTAssertEqual(viewModel.breweryModel.value, .loading)
        let expectation = XCTestExpectation(description: "Fetch Home Data Failure InternetError")
        
        DispatchQueue.main.async {
            if case .error(let errorModel) = self.viewModel.breweryModel.value {
                XCTAssertEqual(errorModel?.titleText, TreinamentoBreweryBeesLocalizable.errorInternet_noConnection.localized)
            } else {
                XCTFail("Expected error state")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
}

class MockHomeCoordinatorDelegate: HomeCoordinatorDelegate {
    func openNextFlow(_ breweryData: BreweryData?) { }
    func openUrl(url urlString: String?) { }
    func finishFlowHome() { }
    func openError(tryAgainAction: @escaping TryAgainHandler) { }
}

// MARK: - Equatable Conformance

extension BreweryListData: Equatable {
    public static func == (lhs: BreweryListData, rhs: BreweryListData) -> Bool {
        return lhs.identifier == rhs.identifier && lhs.breweriesList == rhs.breweriesList
    }
}

extension BreweryData: Equatable {
    public static func == (lhs: BreweryData, rhs: BreweryData) -> Bool {
        return lhs.identifier == rhs.identifier &&
               lhs.name == rhs.name &&
               lhs.logo == rhs.logo &&
               lhs.type == rhs.type &&
               lhs.rating == rhs.rating &&
               lhs.numRating == rhs.numRating &&
               lhs.address == rhs.address &&
               lhs.website == rhs.website &&
               lhs.description == rhs.description
    }
}

extension GenericErrorView.Model: Equatable {
    public static func == (lhs: GenericErrorView.Model, rhs: GenericErrorView.Model) -> Bool {
        return lhs.titleText == rhs.titleText &&
               lhs.descriptionText == rhs.descriptionText &&
               lhs.buttonText == rhs.buttonText
    }
}

extension HomeInfoStatus: Equatable where T: Equatable, E: Equatable {
    public static func == (lhs: HomeInfoStatus<T, E>, rhs: HomeInfoStatus<T, E>) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true
        case (.success(let leftData), .success(let rightData)):
            return leftData == rightData
        case (.error(let leftError), .error(let rightError)):
            return leftError == rightError
        default:
            return false
        }
    }
}
