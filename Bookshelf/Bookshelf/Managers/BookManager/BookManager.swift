//
//  BookManager.swift
//  Bookshelf
//
//  Created by Anastasia on 06.02.2023.
//

import Foundation
import RxSwift
import RxCocoa

protocol BookManagerProtocol {
    var book: BehaviorRelay<[BookFound]?> { get }
    var failureMessage: BehaviorRelay<String?> { get }
    var isLoading: BehaviorRelay<Bool?> { get }
    func getBook()
}

class BookManager: BookManagerProtocol {
    
    //MARK: -
    //MARK: Public Properties
    
    internal var book = BehaviorRelay<[BookFound]?>(value: [])
    internal var failureMessage = BehaviorRelay<String?>(value: nil)
    internal var isLoading = BehaviorRelay<Bool?>(value: nil)
    
    //MARK: -
    //MARK: Methods
    
    internal func getBook() {
        self.isLoading.accept(true)
        resolve(NetworkManagerProtocol.self).getBook() { val in
            self.isLoading.accept(false)
            self.book.accept(val ?? [])
        } onFailure: { error in
            self.failureMessage.accept(error.description)
            self.isLoading.accept(false)
        }
    }
}
