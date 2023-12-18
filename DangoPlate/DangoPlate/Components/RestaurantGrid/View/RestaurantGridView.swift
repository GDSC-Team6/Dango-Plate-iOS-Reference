//
//  RestaurantGridView.swift
//  DangoPlate
//
//  Created by Jinyoung Yoo on 10/14/23.
//

import SwiftUI

struct RestaurantGridView: View {
    @ObservedObject var restaurantGridViewModel: RestaurantGridViewModel
    @StateObject var selectedRestaurantViewModel = SelectedRestaurantViewModel()

    var body: some View {
        ScrollView {
            RestaurantListOptionView(restaurantGridViewModel: restaurantGridViewModel)
            Divider()
            RestaurantListGridView(restaurantGridViewModel, selectedRestaurantViewModel)
        }
        .scrollIndicators(.never)
        .fullScreenCover(isPresented: $selectedRestaurantViewModel.showDetailsView) {
            DetailsView(detailsViewModel: DetailsViewModel(info: selectedRestaurantViewModel.selectedRestaurant), showDetailsView: $selectedRestaurantViewModel.showDetailsView)
        }
    }
}

private struct RestaurantListOptionView: View {
    @ObservedObject var restaurantGridViewModel: RestaurantGridViewModel
    @State private var showSearchRadiusModal = false
    @State private var showFoodTypeFilterModal = false

    fileprivate var body: some View {
        HStack {
            Text("평점순")
                .foregroundStyle(.gray)
            Spacer()
            
            if (restaurantGridViewModel.searchType == .nearyBy) {
                Button(action: {
                    showSearchRadiusModal.toggle()
                } , label: {
                    switch restaurantGridViewModel.searchRadius {
                    case .narrow(_, let narrow):
                        Image(narrow)
                    case .mediumNarrow(_, let mediumNarrow):
                        Image(mediumNarrow)
                    case .medium(_, let medium):
                        Image(medium)
                    case .mediumWide(_, let mediumWide):
                        Image(mediumWide)
                    case .wide(_, let wide):
                        Image(wide)
                    }
                })
            }
            Button(action: {
                showFoodTypeFilterModal.toggle()
            }, label: {
                if (restaurantGridViewModel.foodTypeFilter == .none) {
                    Image("filter_noSelected")
                } else {
                    Image("filterWithBadge")
                }
            })
        }
        .fullScreenCover(isPresented: $showSearchRadiusModal) {
            SelectedSearchRadiusModalView(restaurantGridViewModel: restaurantGridViewModel, showModal: $showSearchRadiusModal)
        }
        .fullScreenCover(isPresented: $showFoodTypeFilterModal) {
            FoodTypeFilterModal(restaurantGridViewModel: restaurantGridViewModel, showModal: $showFoodTypeFilterModal)
        }
        .transaction { transaction in
            transaction.disablesAnimations = true
        }
        .frame(height: 20)
        .padding()
    }
}

private struct RestaurantListGridView: View {
    @ObservedObject var restaurantViewModel: RestaurantGridViewModel
    @ObservedObject var selectedRestaurantViewModel: SelectedRestaurantViewModel
    
    fileprivate init(
        _ restaurantViewModel: RestaurantGridViewModel,
        _ selectedRestaurantViewModel: SelectedRestaurantViewModel) {
        self.restaurantViewModel = restaurantViewModel
        self.selectedRestaurantViewModel = selectedRestaurantViewModel
    }

    fileprivate var body: some View {
        LazyVGrid(columns: [GridItem(.flexible(), spacing: 10), GridItem(.flexible(), spacing: 10)], spacing: 20) {
            ForEach(restaurantViewModel.restaurantList.indices, id: \.self) { idx in
                RestaurantBasicInfoView(selectedRestaurantViewModel: selectedRestaurantViewModel, restaurant: restaurantViewModel.restaurantList[idx], idx: idx + 1)
            }
        }
        .padding()
    }
}

private struct RestaurantBasicInfoView: View {
    @ObservedObject var selectedRestaurantViewModel: SelectedRestaurantViewModel
    let restaurant: Restaurant
    let idx: Int
    var addresField: String {
        if (restaurant.distance.isEmpty) {
            return restaurant.shortAddress
        } else {
            return restaurant.shortAddress + " " + restaurant.distance + "m"
        }
    }

    fileprivate var body: some View {
        VStack(alignment: .leading) {
            Rectangle()
                .aspectRatio(1, contentMode: .fit)
                .foregroundStyle(.gray)
                .overlay(alignment: .topTrailing) {
                    restaurant.isWishList ? Image("like_selected") : Image("like_noSelected")
                }
            Group {
                Text("\(idx). \(restaurant.placeName)")
                    .font(.system(size: 15, weight: .regular))
                    .lineLimit(1)
                    .truncationMode(.tail)
                Text(addresField)
                    .foregroundStyle(.gray)
                    .font(.system(size: 9, weight: .light))
                HStack(spacing: 1) {
                    Image(systemName: "pencil")
                        .renderingMode(.template)
                    Text("\(restaurant.numberOfReviews)")
                }
                .foregroundStyle(.gray)
                .font(.caption)
            }
        }
        .onTapGesture {
            selectedRestaurantViewModel.selectedRestaurant = restaurant
            selectedRestaurantViewModel.showDetailsView.toggle()
        }
    }
}

#Preview {
    RestaurantGridView(restaurantGridViewModel: RestaurantGridViewModel(searchType: .nearyBy, restaurantList: DummyData.createDummyList(capacity: 20)))
}
