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
    
    internal var searchTextObservable = BehaviorRelay<String?>(value: nil)
    internal var book = BehaviorRelay<[BookFound]?>(value: [])
    private var bookManager: BookManagerProtocol {
        return resolve(BookManagerProtocol.self)
    }
    private var networkManager: NetworkManagerProtocol {
        return resolve(NetworkManagerProtocol.self)
    }
    private var disposeBag: DisposeBag = .init()
    
    //MARK: -
    //MARK: Init
    
    internal init() {
        searchTextObservable
            .asObservable()
            .filter({ value in
                (value?.count ?? 0) >= 2
            })
            .bind(to: networkManager.bookSearchURLValue)
            .disposed(by: disposeBag)
        bookManager.book
            .asObservable()
            .bind(to: self.book)
            .disposed(by: disposeBag)
        bookManager.failureMessage
            .asObservable()
            .bind(onNext: { message in
                if let message = message {
                    resolve(Router.self).showError(err: message, show: true)
                }
            }).disposed(by: disposeBag)
        bookManager.isLoading
            .asObservable()
            .bind(onNext: { load in
                if let load = load {
                    switch load {
                    case true:
                        resolve(Router.self).loading(show: load)
                    case false:
                        resolve(Router.self).loading(show: load)
                    }
                }
            }).disposed(by: disposeBag)
    }
    
    //MARK: -
    //MARK: Methods
    
    internal func setData() {
        bookManager.getBook()
    }
    
}
