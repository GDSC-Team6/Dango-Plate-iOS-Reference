//
//  RestaurantListViewModel.swift
//  DangoPlate
//
//  Created by Jinyoung Yoo on 10/14/23.
//

import Foundation
import Alamofire

class RestaurantListViewModel: ObservableObject {
    @Published var restaurantList: [RestaurantBasicInfo]
    @Published var searchRadius: SearchRadius
    @Published var categoryFilter: FilterType.Category
    @Published var foodTypeFilter: [FilterType.FoodType]
    @Published var hasSearchResultList = false
    
    var searchType: SearchType
    
    init (
        restaurantList: [RestaurantBasicInfo] = [],
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
    func addRestaurantList(basicInfo: RestaurantBasicInfo) {
        restaurantList.append(basicInfo)
    }
    
    func updateRestaurantList() {
        restaurantList.removeAll()
    }
    
    func loadRestaurantList(_ query: String) {
        let requestURL = API.RESTAURANT_SEARCH
        let queryParam = ["query": query + " 맛집"]
        let headers: HTTPHeaders = [.accept("application/json")]
        
        var resultList = [RestaurantBasicInfo]()

        AF.request(requestURL, parameters: queryParam, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: SearchResultResponse.self) {
            response in
            switch response.result {
            case .success(let data):
                for document in data.documents {
                    let restaurant = RestaurantBasicInfo(place_name: document.place_name, address: document.address_name)
                    resultList.append(restaurant)
                }
                self.restaurantList = resultList
                self.hasSearchResultList = true
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
