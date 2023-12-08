//
//  DetailsResultResponse.swift
//  DangoPlate
//
//  Created by Demian on 2023/11/14.
//

import Foundation

struct DetailsData: Codable {
    let id: String             // UInt
    let imageUrls: [String]
    let reviewIds: [String]    // UInt
    let shopUid: String        // UInt
    
    enum CodingKeys: String, CodingKey {
        case id, imageUrls, reviewIds, shopUid
    }
}

struct DetailsResultResponse: Codable {
    let data: DetailsData
}
