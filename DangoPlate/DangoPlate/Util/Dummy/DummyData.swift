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
        let address = str.createRandomString(len: 3) + " " + str.createRandomString(len: 2) + "구" + " " + str.createRandomString(len: 3) + "동"
        let numberOfReviews = Int.random(in: 0...50)
        let isWishList = Bool.random()
        
        return Restaurant.createDummyRestaurant(placeName, address, numberOfReviews, isWishList)
    }
    
    static func createDummyList(capacity: Int) -> [Restaurant] {
        let dummyList: [Restaurant] = (0..<capacity).map { _ in self.createDummyData() }
        return dummyList
    }
    
    static func mcdonaldDT() -> Restaurant {
        return Restaurant(id: "27120996", address: "경기 부천시 괴안동 112-23", roadAddress: "경기 부천시 경인로 487", placeName: "맥도날드 부천역곡역DT점", distance: "", phone: "032-214-9000", latitude: "37.48368129744206", longitude: "37.48368129744206", thumbnail: "", numberOfReviews: 0, isWishList: false)
    }
}
