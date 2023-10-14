//
//  CustomTabBar.swift
//  DangoPlate
//
//  Created by Jinyoung Yoo on 10/14/23.
//

import Foundation

struct CustomTabBar {
    enum TabItemType {
        case nearbyTab, myPageTab
    }
    
    var selectedTabItem: TabItemType = .nearbyTab
}
