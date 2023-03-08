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
        viewModel = SearchScreenViewModel()
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func testBookIsNotNil() {
        viewModel.book.accept(someBooks)
        XCTAssertNotNil(viewModel.book.value)
    }
    
}
