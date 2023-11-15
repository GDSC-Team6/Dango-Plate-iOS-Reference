//
//  DangoPlateApp.swift
//  DangoPlate
//
//  Created by Jinyoung Yoo on 10/9/23.
//

import SwiftUI

@main
struct DangoPlateApp: App {

//    @StateObject var userAuth: OAuthViewModel = OAuthViewModel()
    
    var body: some Scene {
        WindowGroup {
//      앞으로 이런 구조로 가야함
//            if userAuth.isLoggedIn {
//                LayoutView()
//                    .environmentObject(userAuth)
//            } else {
//                OAuthView()
//                    .environmentObject(userAuth)
//            }
            OAuthView()
        }
    }
}
