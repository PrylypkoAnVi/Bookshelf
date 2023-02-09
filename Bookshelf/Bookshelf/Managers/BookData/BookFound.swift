//
//  BookFound.swift
//  Bookshelf
//
//  Created by Anastasia on 06.02.2023.
//

import Foundation

struct BookFound: Codable {
    let title: String
    let author: String
    let publishYear: Int
    let numberOfPages: Int
    let coverId: Int?
    let firstSentense: String
}
