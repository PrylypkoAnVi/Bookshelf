//
//  SearchScreenDestination.swift
//  Bookshelf
//
//  Created by Anastasia on 06.02.2023.
//

import UIKit

struct SearchScreenDestination: Destination {
    
    var destination: UIViewController? {
        let contr = SearchScreenViewController.startVC(viewModel: SearchScreenViewModel())
        return contr
    }
    
}
