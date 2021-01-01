//
//  SearchScreenView.swift
//  Bookshelf
//
//  Created by Anastasia on 06.02.2023.
//

import UIKit
import PinLayout

class SearchScreenView: UIView {

    //MARK: -
    //MARK: Properties

    internal var searchBar: UISearchBar = {
        let search = UISearchBar()
        search.placeholder = "Search"
        return search
    }()
    
    //MARK: -
    //MARK: Private Methods
    
    override func layoutSubviews() {
        self.addSubview(searchBar)
        searchBar.pin
            .top()
            .left()
            .right()
    }
}
