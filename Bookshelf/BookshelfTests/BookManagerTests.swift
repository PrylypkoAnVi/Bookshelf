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
    
    override func setUpWithError() throws {
        networkManager = NetworkManagerMock()
        register(networkManager, for: NetworkManagerProtocol.self)
        bookManager = BookManager()
        register(bookManager, for: BookManager.self)
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
        XCTAssertNotNil(bookManager.isLoading.value)
        XCTAssertTrue(bookManager.isLoading.value ?? false)
        networkManager.onFailure?(.noInternetConnection)
        XCTAssertFalse(bookManager.isLoading.value ?? true)
        XCTAssertEqual(bookManager.failureMessage.value, NetworkError.noInternetConnection.description)
    }
    
}
