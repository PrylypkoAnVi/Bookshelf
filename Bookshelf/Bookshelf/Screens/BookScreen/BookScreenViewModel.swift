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
    
    var cover = BehaviorRelay<UIImageView>(value: UIImageView())
    var disposeBag: DisposeBag = .init()
    var book: BookFound
    
    init(book: BookFound) {
        self.book = book
        guard let coverData = book.coverId,
        let url = URL(string: "https://covers.openlibrary.org/b/id/" + "\(coverData)" + ".jpg")
        else { return }
        self.cover.value.af.setImage(withURL: url, placeholderImage: UIImage(named: "loading"), imageTransition: .crossDissolve(5.0))
    }
    
}
