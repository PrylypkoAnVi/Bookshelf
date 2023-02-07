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
    
    var searchTextObservable = BehaviorRelay<String?>(value: nil)

    var bookManager: BookManager {
        return resolve(BookManager.self)
    }
    var networkManager: NetworkManager {
        return resolve(NetworkManager.self)
    }
    var book = BehaviorRelay<[BookFound]?>(value: [])
    var error = BehaviorRelay<String?>(value: nil)
    private var disposeBag: DisposeBag = .init()
    
    init() {
//        self.coverId.asObservable().map{ val in
//            guard let url = URL(string: "https://covers.openlibrary.org/b/id/" + "\(self.coverId.value)" + ".jpg"),
//                  let data = try? Data(contentsOf: url),
//                  let image = UIImage(data: data)
//            else {
//                return UIImage()
//            }
//            return image
//        }.bind(to: self.image).disposed(by: self.disposeBag)
        searchTextObservable.asObservable().map{$0}.bind(to: networkManager.bookSearchURLValue).disposed(by: disposeBag)
        searchTextObservable.asObservable().bind(with: self, onNext: { this, value in
            guard (value?.count ?? 0) > 3 else { return }
        }).disposed(by: disposeBag)
        bookManager.book.asObservable().map{$0}.bind(to: self.book).disposed(by: disposeBag)
    }
    
    //MARK: -
    //MARK: Methods
    
    func setData() {
        bookManager.getBook()
    }
    
}
