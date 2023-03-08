//
//  BookScreenViewModelTests.swift
//  BookshelfTests
//
//  Created by Anastasia on 07.03.2023.
//

import XCTest
@testable import Bookshelf

class BookScreenViewModelTests: XCTestCase {
    var viewModel: BookScreenViewModel!
    var imageDownloader: ImageDownloaderMock!
    let someBook = BookFound(
        title: "title",
        author: "author",
        publishYear: 1,
        numberOfPages: 2,
        coverId: 3,
        firstSentense: "sentense"
        )
    var router: RouterMock!
    
    override func setUpWithError() throws {
        router = RouterMock()
        register(router, for: Router.self)
        imageDownloader = ImageDownloaderMock()
        viewModel = BookScreenViewModel(book: someBook, imageDownloader: imageDownloader)
    }

    override func tearDownWithError() throws {
        imageDownloader = nil
        viewModel = nil
        router = nil
        clearContainer()
    }

    func testBookTransferredCorrectly() throws {
        XCTAssertEqual(someBook, viewModel.book)
    }
    
    func testCoverImageIsNotNill() {
        XCTAssertNotNil(viewModel.coverImage.value)
    }
    
    func testImageDownloaderReceivedRequest() {
        XCTAssertNotNil(imageDownloader.urlRequest)
    }
    
    func testFailureMessage() {
        viewModel.failureMessage.accept("Test error")
        XCTAssertNotNil(router.error)
        XCTAssertTrue(router.show!)
    }
    
}

extension BookFound: Equatable {
    public static func == (lhs: BookFound, rhs: BookFound) -> Bool {
        guard lhs.author == rhs.author,
              lhs.title == rhs.title,
              lhs.coverId == rhs.coverId,
              lhs.firstSentense == rhs.firstSentense,
              lhs.publishYear == rhs.publishYear,
              lhs.numberOfPages == rhs.numberOfPages
        else {
            return false
        }
        return true
    }
}
