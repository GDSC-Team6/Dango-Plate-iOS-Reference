//
//  OAuthView.swift
//  DangoPlate
//
//  Created by Jinyoung Yoo on 10/10/23.
//

// OAuthView.swift
import SwiftUI

struct OAuthView: View {
    
    var body: some View {
        
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    Spacer()
                    Image("DangoPlate")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                    NavigationLink(destination: LayoutView()) {
                        HStack {
                            Spacer()
                            Image("kakao_login_large_narrow")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width * 0.7)
                            Spacer()
                        }
                    }
                    Spacer()
                }
            }
        }
    }
}


#Preview {
    OAuthView()
}
