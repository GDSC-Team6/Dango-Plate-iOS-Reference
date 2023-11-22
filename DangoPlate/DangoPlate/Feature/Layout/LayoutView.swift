//
//  LayoutView.swift
//  DangoPlate
//
//  Created by Jinyoung Yoo on 10/11/23.
//

import UIKit
import SwiftUI

struct LayoutView: View {
    @StateObject var pathModel = PathModel()
    @StateObject var customTabBarViewModel: CustomTabBarViewModel = CustomTabBarViewModel()

    // TODO: - ViewModel로 빼야할 것 같음
    let locationSerivce = LocationService.createLocationService()
    
    var body: some View {
        NavigationStack(path: $pathModel.paths) {
            ZStack {
                contentView()
                
                VStack {
                    Spacer()
                    
                    CustomTabBarView(customTabBarViewModel: customTabBarViewModel)
                }
                
            }
            .navigationDestination(for: PathType.self) { path in
                switch path {
                case .searchView:
                    SearchView()
                        .navigationBarBackButtonHidden()
                default:
                    MyPageView()
//                        .navigationBarBackButtonHidden()
                }
            }
        }
        .environmentObject(pathModel)
    }
    
    @ViewBuilder
    func contentView() -> some View {
        switch customTabBarViewModel.customTabBar.selectedTabItem {
        case .nearbyTab:
            let latitude = locationSerivce.latitude
            let longitude = locationSerivce.longitude

            NearbyRestaurantView(restaurantListViewModel: .init(searchType: .nearyBy, latitude: latitude, longitude: longitude))
        case .myPageTab:
            MyPageView()
        }
    }
}


#Preview {
    LayoutView()
}
