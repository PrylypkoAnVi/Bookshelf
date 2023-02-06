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
    
    var searchScreenViewModel: SearchScreenViewModel {
        return resolve(SearchScreenViewModel.self)
    }
    var bookManager: BookManager {
        return resolve(BookManager.self)
    }
    let bookSearchURLFirst = "https://openlibrary.org/search.json?q="
    let bookSearchURLValue = BehaviorRelay<String?>(value: nil)
//    let coverSearchURLFirst = "https://covers.openlibrary.org/b/id/"
//    let coverSearchURLValue = BehaviorRelay<Int?>(value: nil)
//    let coverSearchURLLast = ".jpg"
    private var disposeBag: DisposeBag = .init()
    init() {
        searchScreenViewModel.searchTextObservable.asObservable().map{$0.lowercased().replacingOccurrences(of: " ", with: "+")}.bind(to: bookSearchURLValue).disposed(by: disposeBag)
//        bookManager.book.asObservable().map{$0?.0?.coverId}.bind(to: coverSearchURLValue).disposed(by: disposeBag)
    }
    
    func getBook(completion: @escaping (BookFound?) -> Void, onFailure: @escaping (NetworkError) -> ()) {
        let bookSearchURL = bookSearchURLFirst + (bookSearchURLValue.value ?? "")
        let bookSearchRequest = AF.request(bookSearchURL, method: HTTPMethod.get, parameters: nil, encoding: URLEncoding.default, headers: HTTPHeaders.default)
        
        bookSearchRequest.validate().responseDecodable(of: BookFoundToDecode.self) { response in
            switch response.result {
            case .success(let data):
                completion(data.docs.first.map{
                    return BookFound(title: $0.title, author: $0.authorName, publishYear: $0.firstPublishYear, numberOfPages: $0.numberOfPagesMedian, coverId: $0.coverI, firstSentense: $0.firstSentence)
                })
                print(data.docs.first?.title)
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
