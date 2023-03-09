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
    
    override func setUpWithError() throws {
        viewModel = SearchScreenViewModel()
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        clearContainer()
    }
    
    func testBookIsNotNil() {
        XCTAssertNotNil(viewModel.book.value, "default value is []. should not fail")
    }
    
    func testSearchTextObservableIsNil() {
        XCTAssertNil(viewModel.searchTextObservable.value)
    }
    
}
