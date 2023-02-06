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
    
    public var book = BehaviorRelay<BookFound?>(value: nil)
}
