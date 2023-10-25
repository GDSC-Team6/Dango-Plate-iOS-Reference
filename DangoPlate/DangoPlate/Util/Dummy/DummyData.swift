//
//  DummyData.swift
//  DangoPlate
//
//  Created by Jinyoung Yoo on 10/25/23.
//

import Foundation

struct DummyData {
    private static let str = "가나다라마바사아자카타파하"
}

extension DummyData {
    private static func createDummyData() -> RestaurantBasicInfo {
        let name = str.createRandomString(len: Int.random(in: 3...6))
        let shortAddress = str.createRandomString(len: 2) + "구"
        let numberOfReviews = Int.random(in: 0...50)
        let isWishList = Bool.random()
        
        return RestaurantBasicInfo(thumbnail: "", name: name, shortAddress: shortAddress, numberOfReviews: numberOfReviews, isWishList: isWishList)
    }
    
    static func createDummyList(capacity: Int) -> [RestaurantBasicInfo] {
        let dummyList: [RestaurantBasicInfo] = (0..<capacity).map { _ in self.createDummyData() }
        return dummyList
    }
}
