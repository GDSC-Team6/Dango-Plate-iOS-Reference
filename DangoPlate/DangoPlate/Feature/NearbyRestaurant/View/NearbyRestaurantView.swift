//
//  HomeView.swift
//  DangoPlate
//
//  Created by Jinyoung Yoo on 10/10/23.
//

import SwiftUI

struct NearbyRestaurantView: View {
    @ObservedObject var restaurantGridViewModel: RestaurantGridViewModel

    var body: some View {
        VStack {
            HeaderView(restaurantGridViewModel: restaurantGridViewModel)
            Divider()
            RestaurantGridView(restaurantGridViewModel: restaurantGridViewModel)
        }
        .onAppear() {
            restaurantGridViewModel.loadRestaurantList()
            restaurantGridViewModel.loadUserLocation()
        }
    }
}

struct HeaderView: View {
    @ObservedObject var restaurantGridViewModel: RestaurantGridViewModel

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("지금 보고있는 지역은")
                    .font(.caption)
                    .fontWeight(.light)
                Text("\(restaurantGridViewModel.region)")
                    .font(.title3)
                    .fontWeight(.light)
            }
            Spacer()
        }
        .padding(.leading)
        .padding(.top)
    }
}

#Preview {
    NearbyRestaurantView(restaurantGridViewModel: RestaurantGridViewModel(searchType: .nearyBy))
}
