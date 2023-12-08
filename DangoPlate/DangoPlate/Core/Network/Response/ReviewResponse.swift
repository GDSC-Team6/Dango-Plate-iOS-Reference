//
//  ReviewResponse.swift
//  DangoPlate
//
//  Created by Demian on 2023/11/14.
//

import Foundation

struct ReviewData: Codable {
    let content: String
    let id: String         // UInt
    let shopId: String    // UInt
    let urls: [String]
    let userId: String    // UInt
    
    enum CodingKeys: String, CodingKey {
        case shopId = "shop_id"
        case userId = "user_id"
        case content, id, urls
    }
}

struct ReviewResponse: Codable {
    let data: ReviewData
}
