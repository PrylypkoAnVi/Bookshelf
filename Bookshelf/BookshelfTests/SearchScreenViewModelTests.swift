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
    var someBooks = [BookFound(
        title: "title1",
        author: "author1",
        publishYear: 1,
        numberOfPages: 1,
        coverId: 1,
        firstSentense: "sentense1"
    ), BookFound(
        title: "title2",
        author: "author2",
        publishYear: 2,
        numberOfPages: 2,
        coverId: 2,
        firstSentense: "sentense2"
    )]
    
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
    
    func testBookManagerFailureMessage() {
        bookManager.failureMessage.accept("Test error")
        XCTAssertNotNil(router.error)
        XCTAssertTrue(router.show!)
    }
    
    func testBookManagerIsLoading() {
        bookManager.isLoading.accept(true)
        XCTAssertTrue(router.show!)
    }
    
    func testSetData() {
        viewModel.setData()
        XCTAssertNotEqual(bookManager.getBookCalled, 0)
        bookManager.book.accept(someBooks)
        XCTAssertEqual(viewModel.book.value, someBooks)
        XCTAssertEqual(bookManager.book.value, viewModel.book.value)
    }
    
    func testSearchTextLetterCount() {
        viewModel.searchTextObservable.accept("A")
        XCTAssertNotEqual(viewModel.searchTextObservable.value, networkManager.bookSearchURLValue.value)
        viewModel.searchTextObservable.accept("Aa")
        XCTAssertEqual(viewModel.searchTextObservable.value, networkManager.bookSearchURLValue.value)
    }
    
}
