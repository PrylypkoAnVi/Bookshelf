//
//  BookManagerTests.swift
//  BookshelfTests
//
//  Created by Anastasia on 08.03.2023.
//

import XCTest
@testable import Bookshelf

final class BookManagerTests: XCTestCase {
    var bookManager: BookManager!
    var networkManager: NetworkManagerMock!
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
        bookManager = BookManager()
    }
    
    override func tearDownWithError() throws {
        bookManager = nil
        networkManager = nil
        clearContainer()
    }
    
    func testFailureMessageIsNil() {
        XCTAssertNil(bookManager.failureMessage.value)
    }
    
    func testLoadingIsNil() {
        XCTAssertNil(bookManager.isLoading.value)
    }
    
    func testBookIsNotNil() {
        XCTAssertNotNil(bookManager.book.value, "default value is []. should not fail")
        XCTAssertEqual(bookManager.book.value?.count, 0)
    }
    
    func testGetBookErrorNoConnectionCatched() {
        XCTAssertNil(bookManager.isLoading.value)
        bookManager.getBook()
        XCTAssertTrue(bookManager.isLoading.value ?? false)
        networkManager.onFailure?(.noInternetConnection)
        XCTAssertFalse(bookManager.isLoading.value ?? true)
        XCTAssertEqual(bookManager.failureMessage.value, NetworkError.noInternetConnection.description)
    }
    
    func testGetBookGetsBooks() {
        XCTAssertNil(bookManager.isLoading.value)
        bookManager.getBook()
        XCTAssertTrue(bookManager.isLoading.value ?? false)
        networkManager.completion?(someBooks)
        XCTAssertFalse(bookManager.isLoading.value ?? true)
        XCTAssertNil(bookManager.failureMessage.value)
        XCTAssertEqual(bookManager.book.value, someBooks)
        
    }
    
}
