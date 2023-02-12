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
        static let imageSize = CGSize(width: 100, height: 150)
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
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.numberOfLines = 3
        return label
    }()
    internal var bookAuthor: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
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
        if data.coverId != nil {
            guard let cover = data.coverId else { return }
            guard let url = URL(string: "https://covers.openlibrary.org/b/id/" + "\(cover)" + ".jpg") else { return }
            print(data.coverId)
            self.bookCover.load(url: url)
        } else {
            self.bookCover.image = UIImage(named: "noCover")
        }
        
        self.bookName.text = data.title
        self.bookAuthor.text = data.author
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
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
        let labelSize = CGSize(width: width - bookCover.frame.width - 20, height: (height / 3) - 10)
        
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
            .marginHorizontal(10)
        bookAuthor.pin
            .after(of: bookCover)
            .below(of: bookName)
            .marginHorizontal(10)
    }
}
