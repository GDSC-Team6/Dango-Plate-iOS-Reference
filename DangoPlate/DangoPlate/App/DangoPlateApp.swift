//
//  DangoPlateApp.swift
//  DangoPlate
//
//  Created by Jinyoung Yoo on 10/9/23.
//
// Launch Screen에서 로그인 관련 일을 하고 데이터 미리 받은 후 LayoutView에 뿌려주는 로직 필요!
import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

@main
struct DangoPlateApp: App {
    @ObservedObject var viewModel = OAuthViewModel()

    init() {
        // Kakao SDK 초기화
        KakaoSDK.initSDK(appKey: "68ed665b02db6a5c7c3b1154ca4947f4")
    }

    var body: some Scene {
        WindowGroup {
            OAuthView(viewModel: viewModel)
        }
    }
}

