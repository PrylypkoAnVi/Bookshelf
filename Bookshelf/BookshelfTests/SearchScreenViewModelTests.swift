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
    
    override func setUpWithError() throws {
        networkManager = NetworkManagerMock()
        register(networkManager, for: NetworkManagerProtocol.self)
        viewModel = SearchScreenViewModel()
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        networkManager = nil
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
    
    func testCompletion() {
        XCTAssertNotNil(networkManager.completion)
    }
    
}
