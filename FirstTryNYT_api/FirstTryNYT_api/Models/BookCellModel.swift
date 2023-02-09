//
//  BookTableViewCellViewModel.swift
//  FirstTryNYT_api
//
//  Created by Nephilim  on 2/6/23.
//

import Foundation


struct BookCellModel {
    let booksName: String
    let booksDescription: String
    let author: String
    let publisher: String
    let rank: Int
    let buyLink: [BuyLink]
    let image: Data
}
