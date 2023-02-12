//
//  BookScreenDestination.swift
//  Bookshelf
//
//  Created by Anastasia on 12.02.2023.
//

import UIKit

struct BookScreenDestination: Destination {
    
    var destination: UIViewController? {
        let contr = BookScreenViewController.startVC(viewModel: BookScreenViewModel())
        return contr
    }
    
}
