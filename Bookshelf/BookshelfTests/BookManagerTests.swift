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
    
    override func setUpWithError() throws {
        bookManager = BookManager()
    }
    
    override func tearDownWithError() throws {
        bookManager = nil
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
    }
}
