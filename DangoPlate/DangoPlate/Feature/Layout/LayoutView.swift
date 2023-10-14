//
//  LayoutView.swift
//  DangoPlate
//
//  Created by Jinyoung Yoo on 10/11/23.
//

import UIKit
import SwiftUI

import SwiftUI

struct LayoutView: View {
    @StateObject var customTabBarViewModel: CustomTabBarViewModel = CustomTabBarViewModel()
    
    var body: some View {
        ZStack {
            ContentView()
            
            VStack {
                Spacer()

                CustomTabBarView(customTabBarViewModel: customTabBarViewModel)
            }

        }
    }
    
    @ViewBuilder
    func ContentView() -> some View {
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
