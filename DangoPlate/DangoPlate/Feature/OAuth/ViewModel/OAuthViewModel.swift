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

class OAuthViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false

    init() {
           // 앱을 시작할 때 토큰 정보를 확인하여 로그인 상태를 설정합니다.
           UserApi.shared.accessTokenInfo { [weak self] (tokenInfo, error) in
               if let tokenInfo = tokenInfo {
                   self?.isLoggedIn = true
               } else {
                   self?.isLoggedIn = false
               }
           }
       }
    
    func isKakaoTalkInstalled() {
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk { [weak self] (oauthToken, error) in
                if oauthToken != nil {
                    self?.isLoggedIn = true
                }
                print(oauthToken?.accessToken ?? "")
                print(error ?? "")
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { [weak self] (oauthToken, error) in
                if oauthToken != nil {
                    self?.isLoggedIn = true
                }
                print(oauthToken?.accessToken ?? "")
                print(error ?? "")
            }
        }
    }
    // access token 을 서버에 보내는 로직
//    func sendTokenAndNicknameToServer(token: String) {
//            let serverURL = "https://localhost:8080" // 서버의 주소
//            let parameters: [String: Any] = [
//                "token": token,
//                "nickname": "사용자 닉네임" // 사용자의 닉네임을 여기에 추가
//            ]
//            
//            AF.request(serverURL, method: .post, parameters: parameters).response { response in
//                switch response.result {
//                case .success:
//                    print("Success: \(String(describing: response.value))")
//                    // 서버 요청 성공 시 처리할 내용을 여기에 추가하세요.
//                    
//                case .failure(let error):
//                    print("Error: \(error)")
//                }
//            }
//        }
}
