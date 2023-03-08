//
//  RouterMock.swift
//  BookshelfTests
//
//  Created by Anastasia on 08.03.2023.
//

import UIKit
@testable import Bookshelf

class RouterMock: Router {
    var currentViewController: UIViewController?
    
    var returnViewController: UIViewController?
    var destination: Bookshelf.Destination?
    
    var error: String?
    var show: Bool?
    
    func route(to destination: Bookshelf.Destination) -> UIViewController? {
        self.destination = destination
        return returnViewController
    }
    
    func showError(err: String, show: Bool) {
        error = err
        self.show = show
    }
    
    func loading(show: Bool) {
        self.show = show
    }
    
}
