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
//                        .navigationBarBackButtonHidden()
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
            NearbyRestaurantView()
        case .myPageTab:
            MyPageView()
        }
    }
}


#Preview {
    LayoutView()
}
