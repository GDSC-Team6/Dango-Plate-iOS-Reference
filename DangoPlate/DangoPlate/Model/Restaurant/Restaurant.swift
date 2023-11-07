//
//  Restaurant.swift
//  DangoPlate
//
//  Created by Jinyoung Yoo on 10/10/23.
//

import Foundation

struct RestaurantBasicInfo: Hashable {
    var thumbnail: String
    var place_name: String
    var address: String
    var shortAddress: String {
        let splitAddress = address.split(separator: " ").map { String($0) }
        let shortAddress = splitAddress[1]
        return shortAddress
    }
    var numberOfReviews: Int
    var isWishList: Bool
    
    init(
        thumbnail: String = "",
        place_name: String,
        address: String,
        numberOfReviews: Int = 0,
        isWishList: Bool = false) {
        self.thumbnail = thumbnail
        self.place_name = place_name
        self.address = address
        self.numberOfReviews = numberOfReviews
        self.isWishList = isWishList
    }
}
