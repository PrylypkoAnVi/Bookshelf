//
//  BookScreenViewModel.swift
//  Bookshelf
//
//  Created by Anastasia on 12.02.2023.
//

import UIKit
import RxSwift
import RxCocoa
import AlamofireImage

class BookScreenViewModel {
    
    //MARK: -
    //MARK: Properties
    
    var cover = BehaviorRelay<UIImageView>(value: UIImageView())
    var disposeBag: DisposeBag = .init()
    var book: BookFound
    var bookManager: BookManager {
        return resolve(BookManager.self)
    }
    
    init(book: BookFound) {
        self.book = book
        guard let url = URL(string: "https://covers.openlibrary.org/b/id/" + "\(book.coverId)" + ".jpg") else { return }
        self.cover.value.af.setImage(withURL: url,
                                     placeholderImage: UIImage(named: "loading"),
                                     imageTransition: .crossDissolve(5.0))
        bookManager.failureMessage
            .asObservable()
            .bind(onNext: { message in
                if let message = message {
                    resolve(Router.self).showError(err: message, show: true)
                }
            }).disposed(by: disposeBag)
    }
}
