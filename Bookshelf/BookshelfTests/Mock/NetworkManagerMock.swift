//
//  NetworkManagerMock.swift
//  BookshelfTests
//
//  Created by Anastasia on 09.03.2023.
//

import Foundation
import Alamofire
import RxCocoa
@testable import Bookshelf

class NetworkManagerMock: NetworkManagerProtocol {
    var bookSearchURLValue = BehaviorRelay<String?>(value: nil)
 
    public var completion: (([BookFound]?) -> Void)?
    public var onFailure: ((NetworkError) -> ())?
    
    func getBook(completion: @escaping ([BookFound]?) -> Void, onFailure: @escaping (NetworkError) -> ()) {
        self.completion = completion
        self.onFailure = onFailure
    }
    
}

