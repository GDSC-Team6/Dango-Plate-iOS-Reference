//
//  SearchResultResponse.swift
//  DangoPlate
//
//  Created by Jinyoung Yoo on 11/7/23.
//

import Foundation

struct Information: Codable {
    let address: String
    let roadAddress: String
    let placeName: String
    let distance: String
    let id: String
    let phone: String
    let latitude: String
    let longitude: String
   
    enum CodingKeys: String, CodingKey {
        case address = "address_name"
        case roadAddress = "road_address_name"
        case placeName = "place_name"
        case latitude = "y"
        case longitude = "x"
        case distance, id, phone
    }
}

struct PlaceDocuments: Codable {
    let documents: [Information]
}

struct SearchResponse: Codable {
    let data: PlaceDocuments
}
