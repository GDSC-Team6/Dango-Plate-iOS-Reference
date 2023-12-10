//
//  Review.swift
//  DangoPlate
//
//  Created by Demian on 2023/11/15.
//

import Foundation

struct Review {
    let reviewId: UInt
    let shopId: UInt
    let userId: UInt
    let content: String
    
    init(reviewId: UInt, shopId: UInt, userId: UInt, content: String) {
        self.reviewId = reviewId
        self.shopId = shopId
        self.userId = userId
        self.content = content
    }
}
