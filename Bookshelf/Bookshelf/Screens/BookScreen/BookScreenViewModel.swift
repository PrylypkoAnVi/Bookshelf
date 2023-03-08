//
//  BookScreenViewModel.swift
//  Bookshelf
//
//  Created by Anastasia on 12.02.2023.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire
import AlamofireImage

protocol ImageDownloaderProtocol {
   func downloadShort(_ urlRequest: URLRequestConvertible,
                       completion: ((AFIDataResponse<Image>) -> Void)?)
        -> RequestReceipt?
}

extension ImageDownloader: ImageDownloaderProtocol {
    func downloadShort(_ urlRequest: Alamofire.URLRequestConvertible, completion: ((AlamofireImage.AFIDataResponse<AlamofireImage.Image>) -> Void)?) -> AlamofireImage.RequestReceipt? {
        self.download(urlRequest, completion: completion)
    }
}

class BookScreenViewModel {
    
    //MARK: -
    //MARK: Properties
    
    internal var book: BookFound
    internal var coverImage = BehaviorRelay<UIImage?>(value: nil)
    internal var failureMessage = BehaviorRelay<String?>(value: nil)
    private var disposeBag: DisposeBag = .init()
    private let downloader: ImageDownloaderProtocol
    
    //MARK: -
    //MARK: Init
    
    internal init(book: BookFound, imageDownloader: ImageDownloaderProtocol = ImageDownloader()) {
        self.book = book
        self.downloader = imageDownloader
        guard let url = URL(string: "https://covers.openlibrary.org/b/id/" + "\(book.coverId)" + ".jpg"),
              let loadingImage = UIImage(named: "loading")
        else {
            return
        }
        let urlRequest = URLRequest(url: url)
        self.coverImage.accept(loadingImage)
        
        _ = downloader.downloadShort(urlRequest, completion: { response in
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
