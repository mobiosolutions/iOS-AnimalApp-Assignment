//
//  PhotoModel.swift
//  Animal
//
//  Created by Arvind Mehta on 13/01/24.
//

import Foundation

// MARK: - Photo
struct PhotoResponse: Codable {
    var id, width, height: Int?
    var url: String?
    var photographer: String?
    var photographerURL: String?
    var photographerID: Int?
    var avgColor: String?
    var src: Src?
    var liked: Bool?
    var alt: String?
    var type: String?

    enum CodingKeys: String, CodingKey {
        case id, width, height, url, photographer
        case photographerURL = "photographer_url"
        case photographerID = "photographer_id"
        case avgColor = "avg_color"
        case src, liked, alt
        case type
    }
}

// MARK: - Src
struct Src: Codable {
    var original, large2X, large, medium: String?
    var small, portrait, landscape, tiny: String?

    enum CodingKeys: String, CodingKey {
        case original
        case large2X = "large2x"
        case large, medium, small, portrait, landscape, tiny
    }
}

