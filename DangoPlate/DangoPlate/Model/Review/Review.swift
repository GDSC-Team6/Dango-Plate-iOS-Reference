//
//  Review.swift
//  DangoPlate
//
//  Created by Demian on 2023/11/15.
//

import Foundation

struct Review: Hashable {
    let reviewId: UInt
    let shopId: UInt
    let userId: UInt
    let content: String
    let imageUrls: [String]
}
