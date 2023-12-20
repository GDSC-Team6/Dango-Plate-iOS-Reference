//
//  Keychain.swift
//  DangoPlate
//
//  Created by 김정원 on 11/30/23.
//
import KeychainAccess
import Foundation
// Keychain에 토큰을 저장하는 함수
private let keychain = Keychain(service: "com.gdsc.team6.DangoPlate.DangoPlate")
 func saveTokens(accessToken: String, refreshToken: String) {
     print("new : \(accessToken)")
    do {
        try keychain
            .accessibility(.afterFirstUnlock)
            .set(accessToken, key: "accessToken")

        try keychain
            .accessibility(.afterFirstUnlock)
            .set(refreshToken, key: "refreshToken")
       
    } catch {
        print("Error saving tokens to keychain: \(error)")
    }
}
func getATK() -> String {
    do {
        let accessToken = try keychain.get("accessToken")
        return accessToken ?? ""
    } catch {
        print("Error retrieving tokens from keychain: \(error)")
        return ""
    }
}
func getRTK() -> String {
    do {
        let refreshToken = try keychain.get("refreshToken")
        return refreshToken ?? ""
    } catch {
        print("Error retrieving tokens from keychain: \(error)")
        return ""
    }
}


