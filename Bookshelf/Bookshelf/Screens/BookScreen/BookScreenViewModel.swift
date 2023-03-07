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
    
    internal var book: BookFound
    internal var coverImage = BehaviorRelay<UIImage?>(value: nil)
    internal var failureMessage = BehaviorRelay<String?>(value: nil)
    private var disposeBag: DisposeBag = .init()
    private let downloader = ImageDownloader()
    
    //MARK: -
    //MARK: Init
    
    internal init(book: BookFound) {
        self.book = book
        guard let url = URL(string: "https://covers.openlibrary.org/b/id/" + "\(book.coverId)" + ".jpg"),
              let loadingImage = UIImage(named: "loading")
        else {
            return
        }
        let urlRequest = URLRequest(url: url)
        self.coverImage.accept(loadingImage)
        
        downloader.download(urlRequest, completion: { response in
            switch response.result {
            case .success(let image):
                self.coverImage.accept(image)
            case .failure(let error):
                if error._code == NSURLErrorTimedOut {
                    self.failureMessage.accept(NetworkError.timeOut.description)
                } else if response.data == nil {
                    self.failureMessage.accept(NetworkError.noInternetConnection.description)
                } else {
                    self.failureMessage.accept(NetworkError.unexpected.description)
                }
            }
        })
        
        self.failureMessage
            .asObservable()
            .bind(onNext: { message in
                if let message = message {
                    resolve(Router.self).showError(err: message, show: true)
                }
            }).disposed(by: disposeBag)
        
    }
}
