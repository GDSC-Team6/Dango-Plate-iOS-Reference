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
                       self?.refreshAccessToken(refreshToken: refreshToken)
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
        // 예시: 카카오 SDK의 토큰 검증 메서드 사용
        UserApi.shared.accessTokenInfo { (_, error) in
            completion(error == nil)
        }
    }
    private func refreshAccessToken(refreshToken: String) {
        // 서버에 리프레시 토큰을 사용하여 액세스 토큰 재발급 요청
        // 서버 엔드포인트, 파라미터 등은 서버의 API 명세에 따라 다를 수 있습니다.
        let refreshURL = "\(API.BASE_URL)/refresh"
        let parameters: Parameters = ["refreshToken": refreshToken]
        
        AF.request(refreshURL, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { [weak self] response in
            switch response.result {
            case .success(let value):
                if let JSON = value as? [String: Any],
                   let newAccessToken = JSON["access_token"] as? String {
                    self?.saveTokens(accessToken: newAccessToken, refreshToken: refreshToken)
                } else {
                    // 리프레시 토큰도 만료된 경우 로그인 화면으로
                    DispatchQueue.main.async {
                        self?.isLoggedIn = false
                    }
                }
            case .failure:
                // 네트워크 오류 또는 기타 오류 처리
                DispatchQueue.main.async {
                    self?.isLoggedIn = false
                }
            }
        }
    }
    func sendTokenToServer(accessToken: String) {
        let parameters: Parameters = ["accessTokenFromSocial": accessToken]
        
        AF.request(API.SERVER_LOGIN, method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { [weak self] response in
            switch response.result {
            case .success(let value):
                if let JSON = value as? [String: Any],
                   let accessToken = JSON["access_token"] as? String,
                   let refreshToken = JSON["refresh_token"] as? String {
                    print(accessToken)
                    self?.saveTokens(accessToken: accessToken, refreshToken: refreshToken)
                }
            case .failure(let error):
                print("Error while sending token to server: \(error)")
            }
        }
    }

    private func saveTokens(accessToken: String, refreshToken: String) {
        do {
            try keychain
                .accessibility(.afterFirstUnlock)
                .set(accessToken, key: "accessToken")
            try keychain
                .accessibility(.afterFirstUnlock)
                .set(refreshToken, key: "refreshToken")
            DispatchQueue.main.async {
                self.isLoggedIn = true
            }
        } catch {
            print("Error saving tokens to keychain: \(error)")
        }
    }
}
