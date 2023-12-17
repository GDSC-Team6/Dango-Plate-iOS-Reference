//
//  SelectedRestaurantViewModel.swift
//  DangoPlate
//
//  Created by Jinyoung Yoo on 12/18/23.
//

import Foundation

class SelectedRestaurantViewModel: ObservableObject {
    @Published var selectedRestaurant: Restaurant!
    @Published var showDetailsView = false
}
