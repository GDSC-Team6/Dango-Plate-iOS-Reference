//
//  CustomTabBar.swift
//  DangoPlate
//
//  Created by Jinyoung Yoo on 10/14/23.
//

import SwiftUI

struct CustomTabBarView: View {
    @StateObject var customTabBarViewModel: CustomTabBarViewModel = CustomTabBarViewModel()
    
    var body: some View {
        ZStack {
            VStack {

                TabBarIndicator()

                HStack {

                    TabItemBtn(customTabBarViewModel: customTabBarViewModel, imageName: "mappin.and.ellipse", caption: "주변맛집", isSelected: customTabBarViewModel.isSelectedNearByTab, tabItem: .nearbyTab
                    )
                    
                    Spacer()
                    
                    TabItemBtn(customTabBarViewModel: customTabBarViewModel, imageName: "person", caption: "내정보", isSelected: customTabBarViewModel.isSelectedMyPageTab, tabItem: .myPageTab)
                }
                .padding(.horizontal, 40)
                .padding(.top, 5)
                
            }

            SearchBtn()
        }
        .background(Color.white)
    }
    
    private func TabBarIndicator() -> some View {
        Rectangle()
            .fill(Color(UIColor(red: 0.81, green: 0.81, blue: 0.81, alpha: 1.00)))
            .opacity(0.5)
            .frame(height: 5)
            .overlay {
                Rectangle()
                    .fill(Color(UIColor(red: 0.68, green: 0.34, blue: 0.15, alpha: 1.00)))
                    .frame(width: 150)
                    .offset(x: -150)
                // TODO: - Animation 구현
            }
    }
    
    private func SearchBtn() -> some View {
        // image
        Image("search.button")
            .resizable()
            .frame(width: 90, height: 90)
            .shadow(color: .gray, radius: 5)
            .offset(y: -12)
            .onTapGesture {
                customTabBarViewModel.selectTabItem(tabItem: .searchTab)
            }
    }
}

private struct TabItemBtn: View {
    @ObservedObject var customTabBarViewModel: CustomTabBarViewModel
    private let imageName: String
    private let caption: String
    private let isSelected: Bool
    private let tabItem: CustomTabBar.TabItemType
    
    fileprivate init(
        customTabBarViewModel: CustomTabBarViewModel,
        imageName: String,
        caption: String,
        isSelected: Bool,
        tabItem: CustomTabBar.TabItemType
    ) {
        self.customTabBarViewModel = customTabBarViewModel
        self.imageName = imageName
        self.caption = caption
        self.isSelected = isSelected
        self.tabItem = tabItem
    }
    
    fileprivate var body: some View {
        VStack(spacing: 5) {
            Image(systemName: imageName)
                .resizable()
                .frame(width: 30, height: 30)
            Text(caption)
                .font(.system(size: 15))
        }
        .foregroundStyle(
            isSelected ?
            Color(UIColor(red: 0.68, green: 0.34, blue: 0.15, alpha: 1.00)) : Color(UIColor(red: 0.81, green: 0.81, blue: 0.81, alpha: 1.00))
        )
        .onTapGesture {
            customTabBarViewModel.selectTabItem(tabItem: tabItem)
        }
    }
}

#Preview {
    CustomTabBarView()
}
