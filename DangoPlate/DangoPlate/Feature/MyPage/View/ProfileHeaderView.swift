//
//  ProfileHeaderView.swift
//  DangoPlate
//
//  Created by 김정원 on 12/1/23.
//

import SwiftUI

struct ProfileHeaderView: View {
    @StateObject var viewModel = MyPageViewModel()
    @State private var showingEditProfile = false
    var body: some View {
        VStack {
            HStack {
                // 이미지가 로드되었으면 그 이미지를 사용, 그렇지 않으면 기본 이미지 사용
                if let image = viewModel.profileImage {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 70, height: 70)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                } else {
                    Image("placeholder") // 기본 이미지 또는 로딩 이미지
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70, height: 70)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                }
                
                
                Text(viewModel.username) // ViewModel에서 가져온 사용자 이름 사용
                    .font(.headline)
                    .foregroundColor(.primary)
                    .padding(5)
                Spacer()
                // 설정 버튼
                Button(action: {
                    self.showingEditProfile = true
                    
                }) {
                    HStack {
                        Image(systemName: "pencil")
                            .imageScale(.medium)
                        Text("수정")
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 39)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                }
                .foregroundColor(.gray)
                .background(
                    NavigationLink(
                        destination: EditProfileView(),
                        isActive: $showingEditProfile
                    ) {
                        EmptyView()
                    }
                        .hidden()
                )
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.white)
        }
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray, lineWidth: 1) // 윤곽선 색상 및 두께 설정
        )
        .onAppear{
            viewModel.fetchUserData()
        }
    }
}

#Preview {
    ProfileHeaderView(viewModel: MyPageViewModel(isPreview: true))
}
