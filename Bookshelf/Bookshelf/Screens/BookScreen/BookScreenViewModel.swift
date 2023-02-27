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
    
    var disposeBag: DisposeBag = .init()
    var book: BookFound
    var bookManager: BookManager {
        return resolve(BookManager.self)
    }
    var coverImage = BehaviorRelay<UIImage?>(value: nil)
    let downloader = ImageDownloader()
    
    init(book: BookFound) {
        self.book = book
        guard let url = URL(string: "https://covers.openlibrary.org/b/id/" + "\(book.coverId)" + ".jpg"),
              let img = UIImage(named: "loading")
        else {
            return
        }
        let urlRequest = URLRequest(url: url)
        self.coverImage.accept(img)
        downloader.download(urlRequest, completion:  { response in
            if case .success(let image) = response.result {
                self.coverImage.accept(image)
            }
        })
        
        bookManager.failureMessage
            .asObservable()
            .bind(onNext: { message in
                if let message = message {
                    resolve(Router.self).showError(err: message, show: true)
                }
            }).disposed(by: disposeBag)
    }
}
