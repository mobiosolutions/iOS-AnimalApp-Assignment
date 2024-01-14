//
//  StatusCommon.swift
//
//
//  Created by  Mac on 02/06/23.
//

import Foundation

struct BaseModal<T:Codable>: Codable {
    
    var page, perPage: Int?
    var photos: T?
    var totalResults: Int?
    var nextPage: String?

    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case photos
        case totalResults = "total_results"
        case nextPage = "next_page"
    }    
}


