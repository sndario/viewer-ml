//
//  ItemDetailInteractorTests.swift
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

class ItemDetailInteractorTests: XCTestCase {
    // MARK: Subject under test

    var sut: ItemDetailInteractor!
    var worker: ItemDetailWorkerMock!
    // MARK: Test lifecycle

    override func setUp() {
        super.setUp()
        setupItemDetailInteractor()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        worker = nil
    }

    // MARK: Test setup

    func setupItemDetailInteractor() {
        worker = ItemDetailWorkerMock()
        sut = ItemDetailInteractor(worker: worker)
        sut.item = ObjectMock.searchResultItem
    }

    // MARK: Test doubles

    class ItemDetailPresentationLogicSpy: ItemDetailPresentationLogic {
        private(set) var presentItemCalled = false
        func presentItem(response: ItemDetail.Load.Response) {
            presentItemCalled = true
        }
    }

    // MARK: Tests

    func testDoLoad() {
        // Given
        let spy = ItemDetailPresentationLogicSpy()
        sut.presenter = spy
        worker.result = ObjectMock.itemDescription
        
        // When
        sut.doLoad()

        // Then
        XCTAssertTrue(spy.presentItemCalled, "")
    }
    
    func testDoLoadFail() {
        // Given
        let spy = ItemDetailPresentationLogicSpy()
        sut.presenter = spy
        worker.error = ViewerError(URLError(URLError.badServerResponse))
        
        // When
        sut.doLoad()
        
        // Then
        XCTAssertTrue(spy.presentItemCalled, "")
    }
}

class ItemDetailWorkerMock: ItemDetailWorkerProtocol {
    
    var result: ItemDescription?
    var error: ViewerError?
    
    func itemDetail(_ id: String,
                    success: @escaping (ItemDescription?) -> Void,
                    failure: @escaping (ViewerError) -> Void) {
        if error != nil {
            failure(error!)
            return
        }
        success(result)
    }
    
}
