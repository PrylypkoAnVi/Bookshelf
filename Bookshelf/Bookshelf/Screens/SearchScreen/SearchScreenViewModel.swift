//
//  SearchScreenViewModel.swift
//  Bookshelf
//
//  Created by Anastasia on 06.02.2023.
//

import UIKit
import RxSwift
import RxCocoa

class SearchScreenViewModel {
    
    //MARK: -
    //MARK: Properties
    
    var searchTextObservable = BehaviorRelay<String>(value: "")
    var title = BehaviorRelay<String?>(value: nil)
    var author = BehaviorRelay<String?>(value: nil)
    var publishYear = BehaviorRelay<Int?>(value: nil)
    var numberOfPages = BehaviorRelay<Int?>(value: nil)
    var coverId = BehaviorRelay<Int?>(value: nil)
    var firstSentense = BehaviorRelay<String?>(value: nil)
    var book: BookManager {
        return resolve(BookManager.self)
    }
    var error = BehaviorRelay<String?>(value: nil)
    private var disposeBag: DisposeBag = .init()
    
    init() {
        book.book.asObservable().map{$0?.title}.bind(to: self.title).disposed(by: disposeBag)
        book.book.asObservable().map{ val in
            val?.author.joined(separator: " ")
        }.bind(to: self.author).disposed(by: disposeBag)
        book.book.asObservable().map{$0?.publishYear}.bind(to: self.publishYear).disposed(by: disposeBag)
        book.book.asObservable().map{$0?.numberOfPages}.bind(to: self.numberOfPages).disposed(by: disposeBag)
        book.book.asObservable().map{$0?.coverId}.bind(to: self.coverId).disposed(by: disposeBag)
        book.book.asObservable().map{ val in
            val?.firstSentense.joined(separator: " ")
        }.bind(to: self.firstSentense).disposed(by: disposeBag)
        book.failureMessage.asObservable().bind(onNext: { message in
            if let message = message {
                resolve(Router.self).showError(err: message, show: true)
            }
        }).disposed(by: disposeBag)
    }
    
    //MARK: -
    //MARK: Methods
    
    func setData() {
        book.getBook()
    }
    
}
