//
//  SearchScreenTableViewCell.swift
//  Bookshelf
//
//  Created by Anastasia on 06.02.2023.
//

import UIKit
import PinLayout
import AlamofireImage

class SearchScreenTableViewCell: UITableViewCell {
    
    enum Sizes {
        static let imageSize = CGSize(width: 100, height: 150)
        static let spacing: CGFloat = 5
        static let doubleSpacing: CGFloat = 10
    }
    
    //MARK: -
    //MARK: Properties
    
    static let cellId = "cell"
    internal var bookCover: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "noCover")
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
        label.numberOfLines = 6
        return label
    }()
        
    //MARK: -
    //MARK: Methods
    
    func setData(_ data: BookFound) {
        guard let cover = data.coverId else { return }
        guard let url = URL(string: "https://covers.openlibrary.org/b/id/" + "\(cover)" + ".jpg") else { return }
        self.bookCover.af.setImage(withURL: url, placeholderImage: UIImage(named: "loading"))
        self.bookName.text = data.title
        self.bookAuthor.text = data.author
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addSubview(bookCover)
        self.addSubview(bookName)
        self.addSubview(bookAuthor)
    }
    
    override func prepareForReuse() {
        self.bookCover.image = nil
        self.bookName.text = nil
        self.bookAuthor.text = nil
        super.prepareForReuse()
    }
    
    override func layoutSubviews() {
        let width = safeAreaLayoutGuide.layoutFrame.width
        let height = safeAreaLayoutGuide.layoutFrame.height
        let nameLabelSize = CGSize(width: width - bookCover.frame.width - 20, height: (height / 3) - Sizes.doubleSpacing)
        let AuthorLabelSize = CGSize(width: width - bookCover.frame.width - 20, height: 2 * (height / 3) - Sizes.doubleSpacing)
        
        bookCover.frame.size = Sizes.imageSize
        bookName.frame.size = nameLabelSize
        bookAuthor.frame.size = AuthorLabelSize
        
        bookCover.pin
            .top(Sizes.spacing)
            .left(Sizes.spacing)
            .bottom(Sizes.spacing)
        bookName.pin
            .after(of: bookCover)
            .top(Sizes.spacing)
            .marginHorizontal(Sizes.doubleSpacing)
        bookAuthor.pin
            .after(of: bookCover)
            .below(of: bookName)
            .marginHorizontal(Sizes.doubleSpacing)
    }
}
