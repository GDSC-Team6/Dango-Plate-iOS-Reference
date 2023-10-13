//
//  HomeView.swift
//  DangoPlate
//
//  Created by Jinyoung Yoo on 10/10/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            HeaderView()
            Divider()
            ScrollView(showsIndicators: false) {
                RestaurantListOptionView()
                Divider()
                RestaurantListView()
            }
            .padding(.bottom, 20)
        }
    }
}

struct HeaderView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("지금 보고있는 지역은")
                    .font(.caption)
                    .fontWeight(.light)
                Text("강서구")
                    .font(.title3)
                    .fontWeight(.light)
            }
            Spacer()
        }
        .padding(.leading)
    }
}

struct RestaurantListOptionView: View {
    var body: some View {
        HStack {
            Text("평점순")
                .foregroundStyle(.gray)
            Spacer()
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
            })
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
            })
        }
        .frame(height: 20)
        .padding()
    }
}

struct RestaurantListView: View {
    var body: some View {
        VStack(alignment: .center) {
            ForEach(1..<100) { i in
                Text("\(i)")
            }
        }
    }
}

#Preview {
    HomeView()
}
