//
//  Login.swift
//  DangoPlate
//
//  Created by 김정원 on 11/27/23.
//

import Foundation
import Alamofire
import KakaoSDKUser
import KeychainAccess

class LoginManager : ObservableObject{
    static let shared = LoginManager()
    private let keychain = Keychain(service: "com.gdsc.team6.DangoPlate.DangoPlate")
    @Published var isLoggedIn: Bool = false
    
    private init() {
        start()  // 객체 초기화 시 start() 메서드를 호출
    }
    
    func start() {
        checkTokenValidity { [weak self] isValid in
            DispatchQueue.main.async {
                self?.isLoggedIn = isValid
            }
        }
    }
    func checkTokenValidity(completion: @escaping (Bool) -> Void) {
        if let accessToken = try? keychain.get("accessToken"),
           let refreshToken = try? keychain.get("refreshToken") {
            
            // 액세스 토큰 유효성 검사
            validateAccessToken(accessToken: accessToken) { [weak self] isValid in
                if isValid {
                    // 액세스 토큰이 유효하면 메인 뷰로 이동
                    DispatchQueue.main.async {
                        self?.isLoggedIn = true
                    }
                } else {
                    // 액세스 토큰이 유효하지 않다면, 리프레시 토큰으로 새 액세스 토큰 요청
                    
                }
            }
        } else {
            // 토큰이 없으면 로그인 화면으로 이동
            DispatchQueue.main.async {
                self.isLoggedIn = false
            }
        }
    }
    
    private func validateAccessToken(accessToken: String, completion: @escaping (Bool) -> Void) {
        // 서버 또는 카카오 SDK를 사용하여 토큰 유효성 검사
        UserApi.shared.accessTokenInfo { (_, error) in
            completion(error == nil)
        }
    }

    func sendTokenToServer(accessToken: String) {
        let parameters: Parameters = ["accessTokenFromSocial": accessToken]
        
        AF.request(API.SERVER_LOGIN, method: .get, parameters: parameters).responseJSON { [weak self] response in
            switch response.result {
            case .success(let value):
                if let JSON = value as? [String: Any],
                   let data = JSON["data"] as? [String: Any],  // 'data' 객체 추출
                   let newAccessToken = data["accessToken"] as? String,  // 'data' 객체 안에서 'accessToken' 추출
                   let newRefreshToken = data["refreshToken"] as? String {  // 'data' 객체 안에서 'refreshToken' 추출
                    print("new: \(newAccessToken)")
                    // Keychain에 토큰 저장
                    saveTokens(accessToken: newAccessToken, refreshToken: newRefreshToken)

                    // 로그인 상태를 true로 변경하여 LayoutView로 전환
                    DispatchQueue.main.async {
                        self?.isLoggedIn = true
                    }
                } else {
                    print("Failed to parse token data")
                }
            case .failure(let error):
                print("Request failed with error: \(error)")
                DispatchQueue.main.async {
                    self?.isLoggedIn = false
                }
            }
        }
    }


    
}
