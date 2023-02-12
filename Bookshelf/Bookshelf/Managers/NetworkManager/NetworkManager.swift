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
    
    var bookManager: BookManager {
        return resolve(BookManager.self)
    }
    let bookSearchURLFirst = "https://openlibrary.org/search.json?q="
    let bookSearchURLValue = BehaviorRelay<String?>(value: nil)
    
    func getBook(completion: @escaping ([BookFound]?) -> Void, onFailure: @escaping (NetworkError) -> ()) {
        let bookSearchURL = bookSearchURLFirst + (bookSearchURLValue.value ?? "")
        let bookSearchRequest = AF.request(bookSearchURL, method: HTTPMethod.get, parameters: nil, encoding: URLEncoding.default, headers: HTTPHeaders.default)
        
        bookSearchRequest.validate().responseDecodable(of: BookFoundToDecode.self) { response in
            switch response.result {
            case .success(let data):
                completion(data.docs.compactMap{
                    guard let title = $0.title,
                          let author = $0.authorName?.joined(separator: " "),
                          let publishYear = $0.firstPublishYear,
                          let numberOfPages = $0.numberOfPagesMedian
                    else { return nil }
                    return BookFound(title: title,
                                     author: "by \(author)",
                                     publishYear: publishYear,
                                     numberOfPages: numberOfPages,
                                     coverId: $0.coverId,
                                     firstSentense: $0.firstSentence?.joined(separator: " ") ?? "")
                })
            case .failure(_):
                if response.data == nil {
                    onFailure(NetworkError.noInternetConnection)
                } else {
                    onFailure(NetworkError.unexpected)
                }
            }
        }
        
    }
}
