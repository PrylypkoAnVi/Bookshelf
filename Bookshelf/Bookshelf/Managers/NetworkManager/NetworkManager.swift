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
                    return BookFound(title: $0.title ?? "Book Name", author: $0.authorName?.joined(separator: " ") ?? "Book Author", publishYear: $0.firstPublishYear ?? 1543, numberOfPages: $0.numberOfPagesMedian ?? 45, coverId: $0.coverI ?? 10947, firstSentense: $0.firstSentence?.joined(separator: " ") ?? "This book is about...")
                })
                print(data.docs)
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
