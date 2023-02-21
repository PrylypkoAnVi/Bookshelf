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
    
    var cover = BehaviorRelay<UIImage>(value: UIImage())
    var disposeBag: DisposeBag = .init()
    var book: BookFound
    
    init(book: BookFound) {
        self.book = book
        guard let url = URL(string: "https://covers.openlibrary.org/b/id/" + "\(book.coverId)" + ".jpg"),
              let data = try? Data(contentsOf: url),
              let image = UIImage(data: data)
        else {
            return
        }
        self.cover.accept(image)
    }
}
