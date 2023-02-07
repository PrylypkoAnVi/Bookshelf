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
    
    var searchScreenViewModel: SearchScreenViewModel!
    var bookManager: BookManager {
        return resolve(BookManager.self)
    }
    let bookSearchURLFirst = "https://openlibrary.org/search.json?q="
    let bookSearchURLValue = BehaviorRelay<String?>(value: nil)

    private var disposeBag: DisposeBag = .init()
    
    func getBook(completion: @escaping ([BookFound]?) -> Void, onFailure: @escaping (NetworkError) -> ()) {
        searchScreenViewModel.searchTextObservable.asObservable().map{$0}.bind(to: bookSearchURLValue).disposed(by: disposeBag)
        let bookSearchURL = bookSearchURLFirst + (bookSearchURLValue.value ?? "")
        let bookSearchRequest = AF.request(bookSearchURL, method: HTTPMethod.get, parameters: nil, encoding: URLEncoding.default, headers: HTTPHeaders.default)
        
        bookSearchRequest.validate().responseDecodable(of: BookFoundToDecode.self) { response in
            switch response.result {
            case .success(let data):
                completion(data.docs.compactMap{
                    return BookFound(title: $0.title, author: $0.authorName.joined(separator: " "), publishYear: $0.firstPublishYear, numberOfPages: $0.numberOfPagesMedian, coverId: $0.coverI, firstSentense: $0.firstSentence.joined(separator: " "))
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
