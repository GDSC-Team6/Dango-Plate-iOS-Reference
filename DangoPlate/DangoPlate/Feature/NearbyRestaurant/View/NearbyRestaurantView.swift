//
//  HomeView.swift
//  DangoPlate
//
//  Created by Jinyoung Yoo on 10/10/23.
//

import SwiftUI

struct NearbyRestaurantView: View {
    @StateObject var restaurantListViewModel: RestaurantListViewModel

    var body: some View {
        VStack {
            HeaderView()
            Divider()
            RestaurantListView(restaurantListViewModel: restaurantListViewModel)
        }
        .onAppear() {
            restaurantListViewModel.loadRestaurantList("")
        }
    }
}

struct HeaderView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("지금 보고있는 지역은")
                    .font(.caption)
                    .fontWeight(.light)
                Text("강서구")
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
    NearbyRestaurantView(restaurantListViewModel: RestaurantListViewModel(searchType: .nearyBy, latitude: "37.5", longitude: "129.121"))
}
