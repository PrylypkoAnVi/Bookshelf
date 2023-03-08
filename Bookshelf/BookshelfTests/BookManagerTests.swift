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
    var router: RouterMock!
    let someBooks = [BookFound(
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
        bookManager = BookManager()
        router = RouterMock()
        register(router, for: Router.self)
    }
    
    override func tearDownWithError() throws {
        bookManager = nil
        router = nil
        clearContainer()
    }
    
    func testFailureMessage() {
        bookManager.failureMessage.accept("Test error")
        XCTAssertNotNil(router.error)
        XCTAssertTrue((router.show != nil))
    }
    
    func testLoadingIsNil() {
        XCTAssertNil(bookManager.isLoading.value)
    }
    
    func testBookIsNotNil() {
        bookManager.book.accept(someBooks)
        XCTAssertNotNil(bookManager.book.value)
    }
}
