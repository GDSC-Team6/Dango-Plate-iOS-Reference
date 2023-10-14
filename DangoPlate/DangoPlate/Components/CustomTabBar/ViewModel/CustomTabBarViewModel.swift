//
//  CustomTabBarViewModel.swift
//  DangoPlate
//
//  Created by Jinyoung Yoo on 10/14/23.
//

import Foundation

class CustomTabBarViewModel: ObservableObject {
    @Published var customTabBar: CustomTabBar = CustomTabBar()
    
    var isSelectedNearByTab: Bool {
        customTabBar.selectedTabItem == .nearbyTab ? true : false
    }
    
    var isSelectedMyPageTab: Bool {
        customTabBar.selectedTabItem == .myPageTab ? true : false
    }
    
}

extension CustomTabBarViewModel {
    func selectTabItem(tabItem: CustomTabBar.TabItemType) {
        customTabBar.selectedTabItem = tabItem
    }
}
