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
    let numFound, start: Int
    let numFoundExact: Bool
    let docs: [Doc]
    let bookFoundNumFound: Int
    let q: String
}

// MARK: - Doc
struct Doc: Codable {
    let key, type: String
    let seed: [String]
    let title, titleSuggest: String
    let editionCount: Int
    let editionKey, publishDate: [String]
    let publishYear: [Int]
    let firstPublishYear, numberOfPagesMedian: Int
    let lccn, publishPlace, oclc, contributor: [String]
    let lcc, ddc, isbn: [String]
    let lastModifiedI, ebookCountI: Int
    let ebookAccess: String
    let hasFulltext, publicScanB: Bool
    let ia, iaCollection: [String]
    let iaCollectionS, lendingEditionS, lendingIdentifierS, printdisabledS: String
    let coverEditionKey: String
    let coverI: Int
    let firstSentence, publisher, language, authorKey: [String]
    let authorName, authorAlternativeName, person, place: [String]
    let subject, idAlibrisID, idAmazon, idBetterWorldBooks: [String]
    let idBodleianOxfordUniversity, idDepósitoLegal: [String]
    let idGoodreads: [String]
    let idGoogle, idHathiTrust, idLibrarything, idPaperbackSwap: [String]
    let idWikidata, idYakaboo, iaLoadedID, iaBoxID: [String]
    let publisherFacet, personKey, placeKey, personFacet: [String]
    let subjectFacet: [String]
    let version: Double
    let placeFacet: [String]
    let lccSort: String
    let authorFacet, subjectKey: [String]
    let ddcSort: String
    let availability: Availability

    
}

// MARK: - Availability
struct Availability: Codable {
    let status: String
    let availableToBrowse, availableToBorrow, availableToWaitlist, isPrintdisabled: Bool
    let isReadable, isLendable, isPreviewable: Bool
    let identifier, isbn: String
    let openlibraryWork, openlibraryEdition: String
    let isRestricted, isBrowseable: Bool
    let src: String
}
