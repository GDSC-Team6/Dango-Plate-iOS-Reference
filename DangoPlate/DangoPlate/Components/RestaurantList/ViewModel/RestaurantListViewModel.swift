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
    
    init (
        restaurantList: [Restaurant] = [],
        searchRadius: SearchRadius = .thirty,
        categoryFilter: FilterType.Category = .all,
        foodTypeFilter: [FilterType.FoodType] = [],
        searchType: SearchType
    ) {
        self.restaurantList = restaurantList
        self.searchRadius = searchRadius
        self.categoryFilter = categoryFilter
        self.foodTypeFilter = foodTypeFilter
        self.searchType = searchType
    }
}

extension RestaurantListViewModel {
    func addRestaurantList(basicInfo: Restaurant) {
        restaurantList.append(basicInfo)
    }
    
    func updateRestaurantList() {
        restaurantList.removeAll()
    }
    
    func loadRestaurantList(_ query: String) {
        let requestURL = API.RESTAURANT_SEARCH
        let queryParam = ["query": query + " 맛집"]
        let headers: HTTPHeaders = [.accept("application/json")]
        
        var resultList = [Restaurant]()

        AF.request(requestURL, parameters: queryParam, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: SearchResponse.self) {
            response in
            switch response.result {
            case .success(let res):
                for document in res.data.documents {
                    let restaurant = Restaurant.createRestaurant(information: document)
                    resultList.append(restaurant)
                }
                self.restaurantList = resultList
                self.hasSearchResultList = true
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
