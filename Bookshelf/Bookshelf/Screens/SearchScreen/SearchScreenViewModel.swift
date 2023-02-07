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
    var image = BehaviorRelay<UIImage?>(value: UIImage())
    var searchTextObservable = BehaviorRelay<String?>(value: nil)
    var title = BehaviorRelay<String?>(value: nil)
    var author = BehaviorRelay<String?>(value: nil)
    var coverId = BehaviorRelay<Int?>(value: nil)
    var book: BookFound {
        return resolve(BookFound.self)
    }
    var bookManager: BookManager {
        return resolve(BookManager.self)
    }
    var error = BehaviorRelay<String?>(value: nil)
    private var disposeBag: DisposeBag = .init()
    
    init() {
        self.title.accept(book.title)
        self.author.accept(book.author)
        self.coverId.asObservable().map{ val in
            guard let url = URL(string: "https://covers.openlibrary.org/b/id/" + "\(self.coverId.value)" + ".jpg"),
                  let data = try? Data(contentsOf: url),
                  let image = UIImage(data: data)
            else {
                return UIImage()
            }
            return image
        }.bind(to: self.image).disposed(by: self.disposeBag)
    }
    
    //MARK: -
    //MARK: Methods
    
    func setData() {
        bookManager.getBook()
    }
    
}
