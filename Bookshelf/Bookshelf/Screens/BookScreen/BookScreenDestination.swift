//
//  BookScreenDestination.swift
//  Bookshelf
//
//  Created by Anastasia on 12.02.2023.
//

import UIKit

struct BookScreenDestination: Destination {
    
    var destination: UIViewController? {
        var viewModel: BookScreenViewModel = BookScreenViewModel()
        viewModel.data.accept(bookFound)
        let contr = BookScreenViewController.startVC(viewModel: viewModel)
        return contr
    }
    
    var bookFound: BookFound
}
