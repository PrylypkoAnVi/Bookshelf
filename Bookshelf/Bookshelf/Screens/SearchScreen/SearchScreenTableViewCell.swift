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
        image.backgroundColor = .gray
        return image
    }()
    internal var bookName: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.backgroundColor = .green
        return label
    }()
    internal var bookAuthor: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.backgroundColor = .blue
        return label
    }()
    private var disposeBag: DisposeBag = .init()
    
    //MARK: -
    //MARK: Methods
    
    func setData(_ data: BookFound) {
        self.bookName.text = data.title
        self.bookAuthor.text = data.author
        self.bookCover.image
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func layoutSubviews() {
        self.addSubview(bookCover)
        self.addSubview(bookName)
        self.addSubview(bookAuthor)
        
        let width = safeAreaLayoutGuide.layoutFrame.width
        let height = safeAreaLayoutGuide.layoutFrame.height
        let labelSize = CGSize(width: width - bookCover.frame.width - 20, height: height / 2)
        
        bookCover.frame.size = Sizes.imageSize
        bookName.frame.size = labelSize
        bookAuthor.frame.size = labelSize
        
        bookCover.pin
            .top()
            .left()
            .bottom()
            .marginVertical(Sizes.verticalSpacing)
            .marginHorizontal(Sizes.spacing)
        bookName.pin
            .after(of: bookCover)
            .top()
            .right()
        bookAuthor.pin
            .after(of: bookCover)
            .below(of: bookName)
            .right()
            .bottom()
    }
}
