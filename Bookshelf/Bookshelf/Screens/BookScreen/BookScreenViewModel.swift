//
//  BookScreenViewModel.swift
//  Bookshelf
//
//  Created by Anastasia on 12.02.2023.
//

import UIKit
import RxSwift
import RxCocoa

class BookScreenViewModel {
    
    //MARK: -
    //MARK: Properties
    
    var title = BehaviorRelay<String?>(value: nil)
    var cover = BehaviorRelay<UIImage>(value: UIImage())
    var author = BehaviorRelay<String?>(value: nil)
    var publishYear = BehaviorRelay<Int?>(value: nil)
    var pages = BehaviorRelay<Int?>(value: nil)
    var firstSentense = BehaviorRelay<String?>(value: nil)
    var disposeBag: DisposeBag = .init()
    
    
    
    
    
    
    
}
