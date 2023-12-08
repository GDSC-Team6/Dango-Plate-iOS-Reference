//
//  DetailsResultResponse.swift
//  DangoPlate
//
//  Created by Demian on 2023/11/14.
//

import Foundation

struct DetailsData: Codable {
    let id: UInt             // UInt
    let imageUrls: [String]
    let reviewIds: [UInt]    // UInt
    let shopUid: UInt        // UInt
    
    enum CodingKeys: String, CodingKey {
        case id, imageUrls, reviewIds, shopUid
    }
}

struct DetailsResponse: Codable {
    let data: DetailsData
}
