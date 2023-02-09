//
//  NamesResponse.swift
//  FirstTryNYT_api
//
//  Created by Nephilim  on 2/8/23.
//

import Foundation


struct NamesResponse: Codable {
    let results: [Results]
    enum CodingKeys: String, CodingKey {
        case results
    }
}
