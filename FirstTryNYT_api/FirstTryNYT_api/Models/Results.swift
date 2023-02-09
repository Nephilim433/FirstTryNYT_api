//
//  Results.swift
//  FirstTryNYT_api
//
//  Created by Nephilim  on 2/8/23.
//

import Foundation

// MARK: - Results
struct Results: Codable {
    let listName, displayName, listNameEncoded:String
    let oldestPublishedDate,newestPublishedDate: String?
    let updated: String
    let publishedDate: String?
    let books: [BookItem]?

    enum CodingKeys: String, CodingKey {
        // те шо приходить від Names
        case listName = "list_name"
        case displayName = "display_name"
        case listNameEncoded = "list_name_encoded"
        case oldestPublishedDate = "oldest_published_date"
        case newestPublishedDate = "newest_published_date"

        //те шо приходить від /current/категорія.джейсон
        case publishedDate = "published_date"
        case updated, books
    }
}
