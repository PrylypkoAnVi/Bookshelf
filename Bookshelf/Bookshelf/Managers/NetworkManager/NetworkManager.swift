//
//  NetworkManager.swift
//  Bookshelf
//
//  Created by Anastasia on 06.02.2023.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa

class NetworkManager {
    
    //MARK: -
    //MARK: Properties
    
    private let bookSearchURLFirst = "https://openlibrary.org/search.json?q="
    internal let bookSearchURLValue = BehaviorRelay<String?>(value: nil)
    
    //MARK: -
    //MARK: Methods
    
    internal func getBook(completion: @escaping ([BookFound]?) -> Void, onFailure: @escaping (NetworkError) -> ()) {
        let bookSearchURL = bookSearchURLFirst + (bookSearchURLValue.value ?? "")
        let bookSearchRequest = AF.request(bookSearchURL, method: HTTPMethod.get, parameters: nil, encoding: URLEncoding.default, headers: HTTPHeaders.default)
        
        bookSearchRequest.validate().responseDecodable(of: BookFoundToDecode.self) { response in
            switch response.result {
            case .success(let data):
                completion(data.docs.compactMap{
                    guard let title = $0.title,
                          let author = $0.authorName?.joined(separator: " "),
                          let publishYear = $0.firstPublishYear,
                          let numberOfPages = $0.numberOfPagesMedian,
                          let coverId = $0.coverId
                    else { return nil }
                    return BookFound(title: title,
                                     author: "by \(author)",
                                     publishYear: publishYear,
                                     numberOfPages: numberOfPages,
                                     coverId: coverId,
                                     firstSentense: $0.firstSentence?.joined(separator: " ") ?? "")
                })
            case .failure(let error):
                if response.data == nil {
                    onFailure(NetworkError.noInternetConnection)
                } else if error._code == NSURLErrorTimedOut {
                    onFailure(NetworkError.timeOut)
                } else {
                    onFailure(NetworkError.unexpected)
                }
            }
        }
    }
}
