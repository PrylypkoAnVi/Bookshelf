//
//  BookScreenDestination.swift
//  Bookshelf
//
//  Created by Anastasia on 12.02.2023.
//

import UIKit

struct BookScreenDestination: Destination {
    
    var destination: UIViewController? {
        let viewModel = BookScreenViewModel(book: bookFound)
        let contr = BookScreenViewController.startVC(viewModel: viewModel)
        return contr
    }
    
    var bookFound: BookFound
}
