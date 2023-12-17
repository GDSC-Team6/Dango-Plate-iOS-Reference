//
//  RestaurantGridViewModel.swift
//  DangoPlate
//
//  Created by Jinyoung Yoo on 10/14/23.
//

import Foundation
import Alamofire

class RestaurantGridViewModel: ObservableObject {
    @Published var restaurantList: [Restaurant]
    @Published var categoryFilter: FilterType.Category
    @Published var hasNewRestaurantList = false
    @Published var region = ""

    var searchRadius: SearchRadius
    var foodTypeFilter: FilterType.FoodType = . none
    let searchType: SearchType
    
    private var query = ""
    private let userLocation = LocationService.requestUserLocation()
    var latitude: String {
        return userLocation.latitude
    }
    var longitude: String {
        return userLocation.longitude
    }

    
    init (
        searchType: SearchType,
        restaurantList: [Restaurant] = [],
        searchRadius: SearchRadius = .wide(3000, "3km"),
        categoryFilter: FilterType.Category = .all
    ) {
        self.restaurantList = restaurantList
        self.searchRadius = searchRadius
        self.categoryFilter = categoryFilter
        self.searchType = searchType
    }
}

extension RestaurantGridViewModel {
    func searchWithQuery(_ query: String) {
        self.query = query
        
        if !restaurantList.isEmpty { restaurantList.removeAll() }
        loadRestaurantList()
    }
    
    func applyFoodTypeFilter(_ foodTypeFilter: FilterType.FoodType) {
        self.foodTypeFilter = foodTypeFilter
        
        if !restaurantList.isEmpty { restaurantList.removeAll() }
        loadRestaurantList()
    }
    
    func applySearchRadius(_ searchRadius: SearchRadius) {
        self.searchRadius = searchRadius
        
        if !restaurantList.isEmpty { restaurantList.removeAll() }
        loadRestaurantList()
    }
    
    func loadRestaurantList() {
        let requestURL = API.RESTAURANT_SEARCH
        let queryParam = makeQueryParameter(searchType)
        let headers: HTTPHeaders = [.accept("application/json")]

        AF.request(requestURL, parameters: queryParam, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: SearchResponse.self) {
            response in
            switch response.result {
            case .success(let res):
                for document in res.data.documents {
                    let restaurant = Restaurant.createRestaurant(information: document)
                    self.restaurantList.append(restaurant)
                }
                self.hasNewRestaurantList = true
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func loadUserLocation() {
        let requestURL = API.USER_LOCATION
        var queryParam = [String: String]()

        queryParam["x"] = longitude
        queryParam["y"] = latitude
        AF.request(requestURL, parameters: queryParam)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: UserLocationResponse.self) {
                response in
                switch response.result {
                case .success(let res):
                    self.region = res.data.region
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
    }
}

extension RestaurantGridViewModel {
    private func makeQueryParameter(_ searchType: SearchType) -> [String: String] {
        let searchingQuery = self.foodTypeFilter == .none ? query : query + self.foodTypeFilter.rawValue + " "
        var queryParam = [String: String]()
        
        switch searchType {
        case .keyword:
            if (!searchingQuery.isEmpty) { queryParam["query"] = searchingQuery + "맛집" }
        case .nearyBy:
            if (!latitude.isEmpty && !longitude.isEmpty) {
                queryParam["query"] = searchingQuery + "맛집"
                queryParam["x"] = longitude
                queryParam["y"] = latitude
                queryParam["radius"] = getSearchRadius()
            }
        }
        
        return queryParam
    }
    
    private func getSearchRadius() -> String {
        var radius: String

        switch self.searchRadius {
        case .narrow(let integer, _):
            radius = String(integer)
        case .mediumNarrow(let integer, _):
            radius = String(integer)
        case .medium(let integer, _):
            radius = String(integer)
        case .mediumWide(let integer, _):
            radius = String(integer)
        case .wide(let integer, _):
            radius = String(integer)
        }
        
        return radius
    }
}
