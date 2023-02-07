//
//  BookManager.swift
//  Bookshelf
//
//  Created by Anastasia on 06.02.2023.
//

import Foundation
import RxSwift
import RxCocoa

class BookManager {
    
    //MARK: -
    //MARK: Public Properties
    
    public var book = BehaviorRelay<[BookFound]?>(value: nil)
    public var failureMessage = BehaviorRelay<String?>(value: nil)
    
    //MARK: -
    //MARK: Methods
    
    func getBook() {
        resolve(NetworkManager.self).getBook() { val in
            self.book.accept(val)
        } onFailure: { error in
            self.failureMessage.accept(error.description)
        }
    }
}
