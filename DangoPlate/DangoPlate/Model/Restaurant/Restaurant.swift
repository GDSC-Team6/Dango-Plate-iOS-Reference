//
//  Restaurant.swift
//  DangoPlate
//
//  Created by Jinyoung Yoo on 10/10/23.
//

import Foundation

struct Restaurant: Hashable {
    let id: String
    let address: String
    let placeName: String
    let distance: String
    let phone: String
    let latitude: String
    let longitude: String
    let thumbnail: String

    var shortAddress: String {
        let removedWhitespaceAddress = address.components(separatedBy: " ")
        return removedWhitespaceAddress[1]
    }
    var numberOfReviews: Int
    var isWishList: Bool
    
    // MEMO: - 초기화 문이 너무 길어 Factory Method로 대체
    static func createRestaurant(information: Information) -> Restaurant {
        return Restaurant(id: information.id, address: information.address, placeName: information.placeName, distance: information.distance, phone: information.phone, latitude: information.latitude, longitude: information.longitude, thumbnail: "", numberOfReviews: 0, isWishList: false)
    }
    
    static func createDummyRestaurant(_ placeName: String, _ address: String, _ numberOfReviews: Int, _ isWishList: Bool ) -> Restaurant {
        Restaurant(id: "", address: address, placeName: placeName, distance: "", phone: "", latitude: "", longitude: "", thumbnail: "", numberOfReviews: numberOfReviews, isWishList: isWishList)
    }
}
