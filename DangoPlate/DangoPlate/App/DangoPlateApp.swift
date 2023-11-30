import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

@main
struct DangoPlateApp: App {
    @StateObject private var loginManager = LoginManager.shared
    @StateObject private var oauthViewModel = OAuthViewModel()  // Create an instance of OAuthViewModel
    
    init() {
        // Kakao SDK 초기화
        KakaoSDK.initSDK(appKey: "\(API.APP_KEY)")
    }
    
    var body: some Scene {
        WindowGroup {
            if loginManager.isLoggedIn {
                LayoutView()
            } else {
                // Pass the instance of OAuthViewModel to OAuthView
                OAuthView(viewModel: oauthViewModel)
                    .environmentObject(loginManager)
            }
        }
    }
}

