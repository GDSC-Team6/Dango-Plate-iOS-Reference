//
//  MyPage.swift
//  DangoPlate
//
//  Created by Jinyoung Yoo on 10/10/23.
//
import SwiftUI
import Foundation
struct MenuRow: View {
    let iconName: String
    let title: String

    var body: some View {
        HStack {
            Image(systemName: iconName)
            Text(title)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
    }
}
struct UserData: Codable {
    struct Data: Codable {
        let createdAt: String
        let updatedAt: String
        let id: Int
        let kakaoId: Int64
        let password: String
        let name: String
        let phone: String
        let imageUrl: String
        let social: String
    }
    
    let code: Int
    let message: String
    let data: Data
}
