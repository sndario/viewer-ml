//
//  SearchViewControllerTests.swift
//  Viewer
//
//  Created by Dario Suarez on 30/06/2019.
//  Copyright (c) 2019 Dario Suarez. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

@testable import Viewer
import XCTest

class SearchViewControllerTests: XCTestCase {
    // MARK: Subject under test
    var sut: SearchViewController!
    var window: UIWindow!

    // MARK: Test lifecycle

    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupSearchViewController()
    }

    override func tearDown() {
        window = nil
        super.tearDown()
    }

    // MARK: Test setup
    
    func setupSearchViewController() {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "SearchVC", bundle: bundle)
        sut = storyboard.instantiateInitialViewController() as? SearchViewController
    }

    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }

    // MARK: Test doubles

    class SearchBusinessLogicSpy: SearchBusinessLogic {
        
        private(set) var doSearchCalled = false

        func doSearch(request: SearchScene.Search.Request) {
            doSearchCalled = true
        }
    }

    // MARK: Tests

    func testViewIsLoaded() {
        loadView()
        XCTAssertNotNil(sut.searchController)
    }
    
    func testDoSearch() {
        loadView()
        let spy = SearchBusinessLogicSpy()
        sut.interactor = spy
        sut.searchController.searchBar.text = "test"
        sut.searchController.searchResultsUpdater?.updateSearchResults(for: sut.searchController)
        XCTAssertNotNil(sut.searchTask)
        wait(for: 2.0)
        XCTAssert(spy.doSearchCalled)
    }
    
    func testDoSearchClear() {
        loadView()
        sut.searchController.searchBar.text = ""
        sut.searchController.searchResultsUpdater?.updateSearchResults(for: sut.searchController)
        XCTAssertNil(sut.resultsVM)
        XCTAssertNil(sut.searchTask)
    }

    func testDisplaySearchResult() {
        // Given
        let viewModel = SearchScene.Search.ViewModel(result: [SearchItemResultViewModel(name: "test", price: "10", image: "")])

        // When
        loadView()
        sut.displaySearchResult(vm: viewModel)

        // Then
        let item = sut.resultsVM?.first
        XCTAssertEqual(item, viewModel.result.first)
        
        
    }
    
    func testDisplayNoInternetConnection() {
        // Given
        let viewModel = NetworkingError.ViewModel(title: "test", detail: "test")
        
        // When
        loadView()
        sut.displayNoInternetConnection(vm: viewModel)
        // Then
    }
    
    func testDisplayServerError() {
        // Given
        let viewModel = NetworkingError.ViewModel(title: "test", detail: "test")
        
        // When
        loadView()
        sut.displaySearchError(vm: viewModel)
        
        // Then
    }

}

extension XCTestCase {
    
    func wait(for duration: TimeInterval) {
        let waitExpectation = expectation(description: "Waiting")
        
        let when = DispatchTime.now() + duration
        DispatchQueue.main.asyncAfter(deadline: when) {
            waitExpectation.fulfill()
        }
        
        // We use a buffer here to avoid flakiness with Timer on CI
        waitForExpectations(timeout: duration + 0.5)
    }
}
