//
//  RestaurantListViewModel.swift
//  DangoPlate
//
//  Created by Jinyoung Yoo on 10/14/23.
//

import Foundation

class RestaurantListViewModel: ObservableObject {
    @Published var restaurantList: [RestaurantBasicInfo]
    @Published var searchRadius: SearchRadius
    @Published var categoryFilter: FilterType.Category
    @Published var foodTypeFilter: [FilterType.FoodType]
    
    init (
        restaurantList: [RestaurantBasicInfo] = [],
        searchRadius: SearchRadius = .thirty,
        categoryFilter: FilterType.Category = .all,
        foodTypeFilter: [FilterType.FoodType] = []
    ) {
        self.restaurantList = restaurantList
        self.searchRadius = searchRadius
        self.categoryFilter = categoryFilter
        self.foodTypeFilter = foodTypeFilter
    }
}

extension RestaurantListViewModel {
    func addRestaurantList(basicInfo: RestaurantBasicInfo) {
        restaurantList.append(basicInfo)
    }
    
    func updateRestaurantList() {
        restaurantList.removeAll()
    }
    
    func loadRestaurantList() {
        // TODO: - 서버와 통신
    }
}
