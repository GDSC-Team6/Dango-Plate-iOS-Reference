//
//  UserLocationResponse.swift
//  DangoPlate
//
//  Created by Jinyoung Yoo on 12/16/23.
//

import Foundation

struct UserLocationData: Codable {
    let region: String
    
    enum CodingKeys: String, CodingKey {
        case region = "depth2"
    }
}

struct UserLocationResponse: Codable {
    let data: UserLocationData
}
