//
//  SearchScreenTableViewCell.swift
//  Bookshelf
//
//  Created by Anastasia on 06.02.2023.
//

import UIKit
import PinLayout
import RxSwift
import RxCocoa

class SearchScreenTableViewCell: UITableViewCell {
    
    enum Sizes {
        static let imageSize = CGSize(width: 100, height: 157)
        static let spacing: CGFloat = 10
        static let verticalSpacing: CGFloat = 5
    }
    
    //MARK: -
    //MARK: Properties
    
    static let cellId = "cell"
    internal var bookCover: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        return image
    }()
    internal var bookName: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    internal var bookAuthor: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    private var disposeBag: DisposeBag = .init()
    
    var bookModel: SearchScreenViewModel {
        return resolve(SearchScreenViewModel.self)
    }
        
    //MARK: -
    //MARK: Methods
    
    func setData(_ data: BookFound) {
        self.bookName.text = data.title
        self.bookAuthor.text = data.author
        guard let url = URL(string: "https://covers.openlibrary.org/b/id/" + "\(data.coverId)" + ".jpg") else { return }
        print(data.coverId)
        self.bookCover.load(url: url)
        
    }
    
    override func prepareForReuse() {
        self.bookCover.image = nil
        self.bookName.text = nil
        self.bookAuthor.text = nil
        super.prepareForReuse()
    }
    
    override func layoutSubviews() {
        self.addSubview(bookCover)
        self.addSubview(bookName)
        self.addSubview(bookAuthor)
        
        let width = safeAreaLayoutGuide.layoutFrame.width
        let height = safeAreaLayoutGuide.layoutFrame.height
        let labelSize = CGSize(width: width - bookCover.frame.width - 20, height: (height / 2) - 5)
        
        self.layer.frame.size = CGSize(width: width, height: 167)
        bookCover.frame.size = Sizes.imageSize
        bookName.frame.size = labelSize
        bookAuthor.frame.size = labelSize
        
        bookCover.pin
            .top(5)
            .left(5)
            .bottom(5)
        bookName.pin
            .after(of: bookCover)
            .top(5)
//            .marginHorizontal(5)
            .right(5)
        bookAuthor.pin
            .after(of: bookCover)
            .below(of: bookName)
//            .marginHorizontal(5)
            .right(5)
            .bottom(5)
    }
}
