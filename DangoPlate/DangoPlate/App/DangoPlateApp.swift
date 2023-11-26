//
//  DangoPlateApp.swift
//  DangoPlate
//
//  Created by Jinyoung Yoo on 10/9/23.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

// DangoPlateApp.swift

@main
struct DangoPlateApp: App {
    @StateObject private var loginManager = LoginManager.shared
    @StateObject private var oauthViewModel = OAuthViewModel()
    init() {
           // Kakao SDK 초기화
        KakaoSDK.initSDK(appKey: "\(API.APP_KEY)")
       }
    var body: some Scene {
        WindowGroup {
            if loginManager.isLoggedIn {
                LayoutView()
            } else {
                OAuthView(viewModel: oauthViewModel)
            }
        }
        
    }
}
