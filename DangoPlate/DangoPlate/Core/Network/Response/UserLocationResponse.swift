//
//  UserLocationResponse.swift
//  DangoPlate
//
//  Created by Jinyoung Yoo on 12/16/23.
//

import Foundation

struct UserLocationData: Codable {
    let tinyAddress: String
    
    enum CodingKeys: String, CodingKey {
        case tinyAddress = "depth2"
    }
}

struct UserLocationResponse: Codable {
    let data: UserLocationData
}
