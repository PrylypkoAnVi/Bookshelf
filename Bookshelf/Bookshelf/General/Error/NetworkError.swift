//
//  NetworkError.swift
//  Bookshelf
//
//  Created by Anastasia on 06.02.2023.
//

import Foundation

enum NetworkError: Error {
    case noInternetConnection
    case timeOut
    case unexpected
}

extension NetworkError {
    var isFatal: Bool {
        if case NetworkError.unexpected = self { return true }
        else { return false }
    }
}

extension NetworkError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .noInternetConnection:
            return "No Internet"
        case .unexpected:
            return "Something went wrong"
        case .timeOut:
            return "Request time out. Please try again"
        }
    }
}
