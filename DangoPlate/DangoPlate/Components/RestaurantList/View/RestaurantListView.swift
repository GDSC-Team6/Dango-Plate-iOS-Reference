//
//  RestaurantListView.swift
//  DangoPlate
//
//  Created by Jinyoung Yoo on 10/14/23.
//

import SwiftUI

struct RestaurantListView: View {
    @StateObject private var restaurantListViewModel = RestaurantListViewModel(restaurantList: DummyData.createDummyList(capacity: 20))

    var body: some View {
        ScrollView {
            RestaurantListOptionView()
            Divider()
            RestaurantListGridView(viewModel: restaurantListViewModel)
        }
        .scrollIndicators(.never)
    }
}

private struct RestaurantListOptionView: View {
    fileprivate var body: some View {
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

// TODO: - 그리드 아이템끼리 간격 양 옆 패딩 간격이랑 맞추기!!!!1

private struct RestaurantListGridView: View {
    @ObservedObject var viewModel: RestaurantListViewModel

    fileprivate var body: some View {
        LazyVGrid(columns: [GridItem(.flexible(), spacing: 10), GridItem(.flexible(), spacing: 10)], spacing: 20) {
            ForEach(viewModel.restaurantList.indices, id: \.self) { idx in
                RestaurantBasicInfoView(basicInfo: viewModel.restaurantList[idx], idx: idx + 1)
            }
        }
        .padding()
    }
}

private struct RestaurantBasicInfoView: View {
    let basicInfo: RestaurantBasicInfo
    let idx: Int

    fileprivate var body: some View {
        VStack(alignment: .leading) {
            Rectangle()
                .aspectRatio(1, contentMode: .fit)
                .foregroundStyle(.gray)
                .overlay(alignment: .topTrailing) {
                    Circle()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(
                            basicInfo.isWishList ? .orange : .white
                        )
                        .padding(.all, 5)
                }
            Group {
                Text("\(idx). \(basicInfo.name)")
                    .font(.system(size: 17, weight: .regular))
                Text(basicInfo.shortAddress)
                    .foregroundStyle(.gray)
                    .font(.system(size: 13, weight: .light))
                HStack(spacing: 1) {
                    Image(systemName: "pencil")
                        .renderingMode(/*@START_MENU_TOKEN@*/.template/*@END_MENU_TOKEN@*/)
                    Text("\(basicInfo.numberOfReviews)")
                }
                .foregroundStyle(.gray)
                .font(.caption)
            }
        }
    }
}

#Preview {
    RestaurantListView()
//    RestaurantBasicInfoView(basicInfo: .init(thumbnail: "", name: "크라이치즈버거", shortAddress: "역곡동", numberOfReviews: 32, isWishList: false), idx: 1)
}
