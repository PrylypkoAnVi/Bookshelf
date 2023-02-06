//
//  BookFound.swift
//  Bookshelf
//
//  Created by Anastasia on 06.02.2023.
//

import Foundation

typealias BookFound = (BookInfo?, BookCover?)

struct BookInfo: Codable {
    let title: String
    let author: [String]
    let publishYear: Int
    let numberOfPages: Int
    let coverId: Int
    let firstSentense: [String]
    
}

struct BookCover: Codable {
    let cover: String
}
