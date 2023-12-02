//
//  API.swift
//  DangoPlate
//
//  Created by Jinyoung Yoo on 11/7/23.
//
import Security
import Foundation

struct API {
    static let BASE_URL = ProcessInfo.processInfo.environment["BASE_URL"]!
    static let URL = ProcessInfo.processInfo.environment["URL"]!
    static let APP_KEY = ProcessInfo.processInfo.environment["APP_KEY"]!
    static var RESTAURANT_SEARCH: String {
        return BASE_URL + "/map/search"
    }
    static var SERVER_LOGIN : String {
        return URL + "/oauth/kakao/login"
    }
    static var USER_DATA : String {
        return URL + "/user/now"
    }
    //"\(API.BASE_URL)/oauth/kakao/login"
}
