//
//  ProfileView.swift
//  DangoPlate
//
//  Created by 김정원 on 10/24/23.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        GeometryReader { geometry in
            HStack {
                Spacer()
                VStack {
                    ZStack(alignment: .bottomTrailing) {
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geometry.size.width * 0.5)
                            .clipShape(Circle())
                        Button(action: {
                            // 버튼 액션
                        }) {
                            Image(systemName: "pencil")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(Color.green)
                                .padding(8)
                                .background(Color.white)
                                .clipShape(Circle())
                                .frame(width: 40, height: 40) // 버튼 크기 조절

                                .shadow(radius: 3)
                        }
                        //.padding(.trailing, -8) // 오른쪽 패딩을 음수로 주어 버튼을 오른쪽으로 이동
                    }
                    Text("정원")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top, 0)
                    //Spacer()
                }
                Spacer()
            }
        }
    }
}

#Preview {
    ProfileView()
}
