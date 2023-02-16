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
    
    var title = BehaviorRelay<String?>(value: nil)
    var cover = BehaviorRelay<UIImageView>(value: UIImageView())
    var author = BehaviorRelay<String?>(value: nil)
    var publishYear = BehaviorRelay<String?>(value: nil)
    var pages = BehaviorRelay<String?>(value: nil)
    var firstSentense = BehaviorRelay<String?>(value: nil)
    var disposeBag: DisposeBag = .init()
    var data = BehaviorRelay<BookFound?>(value: nil)
    
    var book: BookFound
    
    init(book: BookFound) {
        self.book = book
        self.title.accept(book.title)
        self.author.accept(book.author)
        self.publishYear.accept("\(book.publishYear)")
        self.pages.accept("\(book.numberOfPages)")
        self.firstSentense.accept(book.firstSentense)
        guard let coverData = book.coverId,
        let url = URL(string: "https://covers.openlibrary.org/b/id/" + "\(coverData)" + ".jpg")
        else { return }
        self.cover.value.af.setImage(withURL: url, placeholderImage: UIImage(named: "loading"))
    }
    
//    init() {
//        self.data.asObservable().map{$0?.title}.bind(to: self.title).disposed(by: disposeBag)
//        self.data.asObservable().map{$0?.author}.bind(to: self.author).disposed(by: disposeBag)
//        self.data.asObservable().map{ val in
//            guard let date = val?.publishYear else { return "" }
//            return "Publish year: " + "\(date)"
//        }.bind(to: self.publishYear).disposed(by: disposeBag)
//        self.data.asObservable().map{ val in
//            guard let pages = val?.numberOfPages else { return "" }
//            return "Number of pages: " + "\(pages)"
//        }.bind(to: self.pages).disposed(by: disposeBag)
//        self.data.asObservable().map{$0?.firstSentense}.bind(to: self.firstSentense).disposed(by: disposeBag)
//        self.data.asObservable().map{ val in
//            guard let cover = val?.coverId,
//            let url = URL(string: "https://covers.openlibrary.org/b/id/" + "\(cover)" + ".jpg"),
//            let data = try? Data(contentsOf: url),
//            let image = UIImage(data: data)
//            else {
//                return UIImage()
//            }
//            return image
//        }.bind(to: self.cover).disposed(by: disposeBag)
        
        
//    }
    
}
