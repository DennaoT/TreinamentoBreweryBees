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
    
    override func setUp() {
        super.setUp()
        mockDelegate = MockHomeCoordinatorDelegate()
        viewModel = HomeViewModel(delegate: mockDelegate)
    }
    
    override func tearDown() {
        viewModel = nil
        mockDelegate = nil
        super.tearDown()
    }
    
    func testFetchHomeDataSuccess() {
        // Mock the BreweryBeesManager response
        BreweryBeesManager.shared = MockBreweryBeesManager(result: .success(MockBreweryListData.breweryListData))
        
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
