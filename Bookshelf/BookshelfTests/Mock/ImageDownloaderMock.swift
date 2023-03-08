//
//  ImageDownloaderMock.swift
//  BookshelfTests
//
//  Created by Anastasia on 08.03.2023.
//

import Foundation
import Alamofire
import AlamofireImage
@testable import Bookshelf

class ImageDownloaderMock: ImageDownloaderProtocol {
    public var urlRequest: Alamofire.URLRequestConvertible!
    public var completion: ((AlamofireImage.AFIDataResponse<AlamofireImage.Image>) -> Void)?
    public var result: AlamofireImage.RequestReceipt?
    
    func downloadShort(_ urlRequest: Alamofire.URLRequestConvertible, completion: ((AlamofireImage.AFIDataResponse<AlamofireImage.Image>) -> Void)?) -> AlamofireImage.RequestReceipt? {
        self.urlRequest = urlRequest
        self.completion = completion
        return result
    }
    
    
}
