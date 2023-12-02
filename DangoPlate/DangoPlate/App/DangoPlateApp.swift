import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

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
                    .environmentObject(loginManager)  // 로그인 관리자를 환경 객체로 전달
            } else {
                OAuthView(viewModel: oauthViewModel)
                    .environmentObject(loginManager)
            }
        }
    }
}
