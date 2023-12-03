//
//  OAuthViewModel.swift
//  DangoPlate
//
//  Created by Jinyoung Yoo on 10/10/23.
//
import Alamofire
import Foundation
import KakaoSDKUser
import SwiftUI
import KeychainAccess // Keychain 라이브러리를 import 해야 합니다.

// OAuthViewModel.swift

class OAuthViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false

    func isKakaoTalkInstalled() {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { [weak self] (oauthToken, error) in
                if let token = oauthToken?.accessToken {
                    LoginManager.shared.sendTokenToServer(accessToken: token)
                }
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { [weak self] (oauthToken, error) in
                if let token = oauthToken?.accessToken {
                    LoginManager.shared.sendTokenToServer(accessToken: token)
                }
            }
        }
    }
}
