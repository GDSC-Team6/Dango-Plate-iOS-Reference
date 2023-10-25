//
//  CustomTabBar.swift
//  DangoPlate
//
//  Created by Jinyoung Yoo on 10/14/23.
//

import SwiftUI

struct CustomTabBarView: View {
    @EnvironmentObject private var pathModel: PathModel
    @ObservedObject var customTabBarViewModel: CustomTabBarViewModel
    
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
                .padding(.horizontal, 50)
                
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
            .frame(width: 70, height: 70)
            .shadow(color: .gray.opacity(0.8), radius: 5)
            .offset(y: -5)
            .onTapGesture {
                pathModel.paths.append(.searchView)
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
                .frame(width: 20, height: 20)
            Text(caption)
                .font(.system(size: 10))
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
    CustomTabBarView(customTabBarViewModel: CustomTabBarViewModel())
}
