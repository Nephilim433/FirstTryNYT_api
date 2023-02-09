//
//  Models.swift
//  FirstTryNYT_api
//
//  Created by Nephilim  on 2/6/23.
//


import Foundation

// MARK: - BookItem
struct BookItem: Codable {
    let rank: Int
    let publisher, description: String
    let title, author, contributor: String
    let bookImage: String
    let buyLinks: [BuyLink]

    enum CodingKeys: String, CodingKey {
        case rank
        case publisher, description, title, author, contributor
        case bookImage = "book_image"
        case buyLinks = "buy_links"
    }
}



