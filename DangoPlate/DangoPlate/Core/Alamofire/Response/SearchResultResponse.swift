//
//  SearchResultResponse.swift
//  DangoPlate
//
//  Created by Jinyoung Yoo on 11/7/23.
//

import Foundation

struct SearchResult: Codable {
    let address_name: String
    let place_name: String
}

struct SearchResultResponse: Codable {
    let documents: [SearchResult]
}
