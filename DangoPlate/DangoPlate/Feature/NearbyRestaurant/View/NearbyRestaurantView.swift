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
            HeaderView()
            Divider()
            RestaurantGridView(restaurantGridViewModel: restaurantGridViewModel)
        }
        .onAppear() {
            restaurantGridViewModel.loadRestaurantList("")
        }
    }
}

struct HeaderView: View {
    var body: some View {
        HStack {
            // TODO: - 위도 경도로 어디 지역인지 알아와야 함
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
    NearbyRestaurantView(restaurantGridViewModel: RestaurantGridViewModel(searchType: .nearyBy))
}
