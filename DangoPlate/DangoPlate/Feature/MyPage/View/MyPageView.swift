//
//  MyPageView.swift
//  DangoPlate
//
//  Created by Jinyoung Yoo on 10/10/23.
//

import SwiftUI

struct MyPageView: View {
    var body: some View {
        GeometryReader { geometry in
            VStack {
                //Spacer()
                ProfileView()
                    .frame(height: geometry.size.height / 2)
                List{                        
                    Button(action: {
                        // 버튼을 클릭했을 때 실행할 코드
                    }) {
                        Text("내가 쓴 리뷰")
                    }
                    Button(action: {
                        // 버튼을 클릭했을 때 실행할 코드
                    }) {
                        Text("가고 싶다")
                    }

                    Button(action: {
                        // 버튼을 클릭했을 때 실행할 코드
                    }) {
                        Text("마이리스트")
                    }

                    Button(action: {
                        // 버튼을 클릭했을 때 실행할 코드
                    }) {
                        Text("내가 쓴 리뷰")
                    }

                    Button(action: {
                        // 버튼을 클릭했을 때 실행할 코드
                    }) {
                        Text("로그아웃")
                    }

                    
                }
                .listStyle(PlainListStyle()) // 리스트 스타일 설정

            }
        }
    }
}

#Preview {
    MyPageView()
}
