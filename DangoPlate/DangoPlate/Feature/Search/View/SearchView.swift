//
//  SearchView.swift
//  DangoPlate
//
//  Created by Jinyoung Yoo on 10/10/23.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject private var pathModel: PathModel
    @StateObject var restaurantGridViewModel = RestaurantGridViewModel(searchType: .keyword)
    @FocusState private var isSearchingFieldFocused: Bool
    @State private var query = ""

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    pathModel.paths.removeLast()
                }, label: {
                    Image(systemName: "chevron.backward")
                        .renderingMode(/*@START_MENU_TOKEN@*/.template/*@END_MENU_TOKEN@*/)
                        .foregroundStyle(.dangoBrown)
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                })
                TextField("키워드로 검색해보세요.", text: $query, onEditingChanged: { _ in
                    restaurantGridViewModel.hasNewRestaurantList = false
                })
                    .font(.system(size: 17))
                    .padding(.horizontal, 5)
                    .focused($isSearchingFieldFocused)
                    .autocorrectionDisabled()
                    .onSubmit {
                        restaurantGridViewModel.searchWithQuery(query)
                    }
                    .onAppear {
                        isSearchingFieldFocused = true
                    }
            }
            .padding(.bottom, 10)
            .padding(.horizontal, 15)

            Divider()
            
            Spacer()
            
            if (restaurantGridViewModel.hasNewRestaurantList) {
                RestaurantGridView(restaurantGridViewModel: restaurantGridViewModel)
            }
        }
        .padding(.top, 15)
    }
}

#Preview {
    SearchView()
}
