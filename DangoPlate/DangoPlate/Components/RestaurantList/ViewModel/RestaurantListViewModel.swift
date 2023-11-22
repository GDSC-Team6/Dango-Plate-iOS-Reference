//
//  RestaurantListViewModel.swift
//  DangoPlate
//
//  Created by Jinyoung Yoo on 10/14/23.
//

import Foundation
import Alamofire

class RestaurantListViewModel: ObservableObject {
    @Published var restaurantList: [Restaurant]
    @Published var searchRadius: SearchRadius
    @Published var categoryFilter: FilterType.Category
    @Published var foodTypeFilter: [FilterType.FoodType]
    @Published var hasSearchResultList = false
    
    var searchType: SearchType
    let latitude: String
    let longitude: String
    
    init (
        searchType: SearchType,
        restaurantList: [Restaurant] = [],
        searchRadius: SearchRadius = .thirty,
        categoryFilter: FilterType.Category = .all,
        foodTypeFilter: [FilterType.FoodType] = [],
        latitude: String = "",
        longitude: String = ""
    ) {
        self.restaurantList = restaurantList
        self.searchRadius = searchRadius
        self.categoryFilter = categoryFilter
        self.foodTypeFilter = foodTypeFilter
        self.searchType = searchType
        self.latitude = latitude
        self.longitude = longitude
    }
}

extension RestaurantListViewModel {
    func addRestaurantList(_ restaurant: Restaurant) {
        restaurantList.append(restaurant)
    }
    
    func updateRestaurantList(_ query: String) {
        restaurantList.removeAll()
        loadRestaurantList(query)
    }
    
    func loadRestaurantList(_ query: String) {
        let requestURL = API.RESTAURANT_SEARCH
        let queryParam = makeQueryParameter(searchType, query)
        let headers: HTTPHeaders = [.accept("application/json")]

        AF.request(requestURL, parameters: queryParam, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: SearchResponse.self) {
            response in
            switch response.result {
            case .success(let res):
                for document in res.data.documents {
                    let restaurant = Restaurant.createRestaurant(information: document)
                    self.addRestaurantList(restaurant)
                }
                self.hasSearchResultList = true
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    private func makeQueryParameter(_ searchType: SearchType, _ query: String) -> [String: String] {
        var queryParam = [String: String]()
        
        switch searchType {
        case .keyword:
            if (!query.isEmpty) { queryParam["query"] = query + " 맛집" }
        case .nearyBy:
            if (!latitude.isEmpty && !longitude.isEmpty) {
                queryParam["query"] = "맛집"
                queryParam["x"] = longitude
                queryParam["y"] = latitude
                queryParam["radius"] = searchRadius.rawValue
            }
        }
        
        return queryParam
    }
}
