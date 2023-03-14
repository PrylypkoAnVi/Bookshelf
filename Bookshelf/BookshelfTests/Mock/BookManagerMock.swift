//
//  BookManagerMock.swift
//  BookshelfTests
//
//  Created by Anastasia on 14.03.2023.
//

import Foundation
import RxCocoa
@testable import Bookshelf

class BookManagerMock: BookManagerProtocol {
    var book = BehaviorRelay<[BookFound]?>(value: [])
    var failureMessage = BehaviorRelay<String?>(value: nil)
    var isLoading = BehaviorRelay<Bool?>(value: nil)
    var getBookCalled: Int = 0
    
    func getBook() {
        getBookCalled += 1
    }
  
}
