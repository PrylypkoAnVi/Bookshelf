//
//  SearchScreenTableViewCell.swift
//  Bookshelf
//
//  Created by Anastasia on 06.02.2023.
//

import UIKit
import PinLayout

class SearchScreenTableViewCell: UITableViewCell {
    static let cellId = "cell"
    
    internal var bookCover: UIImageView = {
        let image = UIImageView()
        return image
    }()
    internal var bookName: UILabel = {
        let label = UILabel()
        return label
    }()
    internal var bookAuthor: UILabel = {
        let label = UILabel()
        return label
    }()
    
    
}
