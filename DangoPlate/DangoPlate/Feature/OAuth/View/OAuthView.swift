//
//  OAuthView.swift
//  DangoPlate
//
//  Created by Jinyoung Yoo on 10/10/23.
//

// OAuthView.swift
import SwiftUI
import KakaoSDKUser
import KakaoSDKAuth

struct OAuthView: View {
    @ObservedObject private var viewModel = OAuthViewModel()

    var body: some View {
        if viewModel.isLoggedIn {
            LayoutView() // 로그인에 성공하면 LayoutView를 표시합니다.
        } else {
            GeometryReader { geometry in
                VStack {
                    Spacer()
                    Image("DangoPlate")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        
                    Button(action: {
                        viewModel.isKakaoTalkInstalled()
                    }) {
                        HStack {
                            Spacer()
                            Image("kakao_login_large_narrow")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width * 0.7)
                            Spacer()
                        }
                    }
                    Spacer()
                }
                .onOpenURL(perform: { url in
                    if (AuthApi.isKakaoTalkLoginUrl(url)) {
                        _ = AuthController.handleOpenUrl(url: url)
                    }
                })
            }
        }
    }
}


#Preview {
    OAuthView()
}
