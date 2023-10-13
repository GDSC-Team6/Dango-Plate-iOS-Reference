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
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack {
            HomeView()
            
            VStack {
                Spacer()
                CustomTabBarView()
            }

        }
    }
}


#Preview {
    LayoutView()
}
