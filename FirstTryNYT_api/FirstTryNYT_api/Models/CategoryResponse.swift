//
//  CategoryResponse.swift
//  FirstTryNYT_api
//
//  Created by Nephilim  on 2/8/23.
//

import Foundation

//MARK: - CategoryResponse
struct CategoryResponse: Codable {
    let lastModified: Date?
    let results: Results

    enum CodingKeys: String, CodingKey {
        case lastModified = "last_modified"
        case results
    }
}

