//
//  BookFoundToDecode.swift
//  Bookshelf
//
//  Created by Anastasia on 06.02.2023.
//

import Foundation
import Alamofire

// MARK: - BookFound
struct BookFoundToDecode: Codable {
    let docs: [Doc]
}

// MARK: - Doc
struct Doc: Codable {
    let title: String?
    let firstPublishYear: Int?
    let numberOfPagesMedian: Int?
    let coverI: Int?
    let firstSentence: [String]?
    let authorName: [String]?
    
    
    enum CodingKeys: String, CodingKey, Codable {
            case title
            case firstPublishYear = "first_publish_year"
            case numberOfPagesMedian = "number_of_pages_median"
            case coverI = "cover_i"
            case firstSentence = "first_sentence"
            case authorName = "author_name"
        }
}
