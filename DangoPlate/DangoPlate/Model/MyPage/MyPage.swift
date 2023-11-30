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
