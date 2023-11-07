//
//  API.swift
//  DangoPlate
//
//  Created by Jinyoung Yoo on 11/7/23.
//

import Foundation

struct API {
    static let BASE_URL = ProcessInfo.processInfo.environment["BASE_URL"]!
    
    static var RESTAURANT_SEARCH: String {
        return BASE_URL + "/map/search"
    }
}

