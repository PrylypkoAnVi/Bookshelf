//
//  SearchScreenViewModelTests.swift
//  BookshelfTests
//
//  Created by Anastasia on 08.03.2023.
//

import XCTest
@testable import Bookshelf

final class SearchScreenViewModelTests: XCTestCase {
    var viewModel: SearchScreenViewModel!
    var networkManager: NetworkManagerMock!
    var bookManager: BookManagerMock!
    var router: RouterMock!
    
    override func setUpWithError() throws {
        networkManager = NetworkManagerMock()
        register(networkManager, for: NetworkManagerProtocol.self)
        bookManager = BookManagerMock()
        register(bookManager, for: BookManagerProtocol.self)
        router = RouterMock()
        register(router, for: Router.self)
        viewModel = SearchScreenViewModel()
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        router = nil
        networkManager = nil
        bookManager = nil
        clearContainer()
    }
    
    func testBookIsNotNil() {
        XCTAssertNotNil(viewModel.book.value, "default value is []. should not fail")
    }
    
    func testSearchTextObservableIsNil() {
        XCTAssertNil(viewModel.searchTextObservable.value)
    }
    
    func testOnFailureIsNil() {
        XCTAssertNil(networkManager.onFailure)
    }
    
    func testSearchTextAndBookSearchURLValueEqual() {
        viewModel.searchTextObservable.accept("TEST")
        XCTAssertEqual(networkManager.bookSearchURLValue.value, viewModel.searchTextObservable.value)
    }
    
    func testBookManagerBookAndViewModelBookAreEqual() {
        XCTAssertEqual(bookManager.book.value, viewModel.book.value)
    }
    
    func testBookManagerFailureMessageIsNil() {
        bookManager.failureMessage.accept("Test error")
        XCTAssertNotNil(router.error)
        XCTAssertTrue(router.show!)
    }
    
    func testBookManagerIsLoadingIsNil() {
        bookManager.isLoading.accept(true)
        XCTAssertTrue(router.show!)
    }
    
    func testSetDataFunc() {
        viewModel.setData()
        XCTAssertNotEqual(bookManager.getBookCalled, 0)
    }
}
