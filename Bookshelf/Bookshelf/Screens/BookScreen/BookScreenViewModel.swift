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
    var cover = BehaviorRelay<UIImage>(value: UIImage())
    var author = BehaviorRelay<String?>(value: nil)
    var publishYear = BehaviorRelay<Int?>(value: nil)
    var pages = BehaviorRelay<Int?>(value: nil)
    var firstSentense = BehaviorRelay<String?>(value: nil)
    var disposeBag: DisposeBag = .init()
    var data = BehaviorRelay<BookFound?>(value: nil)
    
    init() {
        self.data.asObservable().map{$0?.title}.bind(to: self.title).disposed(by: disposeBag)
        self.data.asObservable().map{$0?.author}.bind(to: self.author).disposed(by: disposeBag)
        self.data.asObservable().map{$0?.publishYear}.bind(to: self.publishYear).disposed(by: disposeBag)
        self.data.asObservable().map{$0?.numberOfPages}.bind(to: self.pages).disposed(by: disposeBag)
        self.data.asObservable().map{$0?.firstSentense}.bind(to: self.firstSentense).disposed(by: disposeBag)
        self.data.asObservable().map{ val in
            guard let url = URL(string: "https://covers.openlibrary.org/b/id/" + "\(val?.coverId)" + ".jpg"),
            let data = try? Data(contentsOf: url),
            let image = UIImage(data: data)
            else {
                return UIImage()
            }
            return image
        }.bind(to: self.cover).disposed(by: disposeBag)
    }
    
    
    
}
