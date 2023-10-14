//
//  RestaurantListView.swift
//  DangoPlate
//
//  Created by Jinyoung Yoo on 10/14/23.
//

import SwiftUI

struct RestaurantListView: View {
    var body: some View {
        ScrollView {
            RestaurantListOptionView()
            Divider()
            VStack(alignment: .center) {
                ForEach(1..<100) { i in
                    Text("\(i)")
                }
            }
        }
        .scrollIndicators(.never)
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

#Preview {
    RestaurantListView()
}
