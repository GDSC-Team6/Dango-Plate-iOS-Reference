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
    private static func createDummyData() -> Restaurant {
        let placeName = str.createRandomString(len: Int.random(in: 3...6))
        let address = str.createRandomString(len: 3) + " " + str.createRandomString(len: 2) + "구" + " " + str.createRandomString(len: 4)
        let numberOfReviews = Int.random(in: 0...50)
        let isWishList = Bool.random()
        
        return Restaurant.createDummyRestaurant(placeName, address, numberOfReviews, isWishList)
    }
    
    static func createDummyList(capacity: Int) -> [Restaurant] {
        let dummyList: [Restaurant] = (0..<capacity).map { _ in self.createDummyData() }
        return dummyList
    }
}
