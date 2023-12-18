//
//  SwiftUIView.swift
//  DangoPlate
//
//  Created by Demian on 2023/11/02.
//

import SwiftUI
import MapKit
import CoreLocation

struct DetailsView: View {
    @ObservedObject var detailsViewModel: DetailsViewModel
    
    var body: some View {
        ScrollView {
            VStack( spacing: 8.0) {
                
                DetailHeaderView(detailsViewModel: detailsViewModel)
                Divider()
                MapView(mapViewModel: MapViewModel(restaurant: detailsViewModel.info))
                
                Divider()
                
                LazyVStack {
                    ForEach(detailsViewModel.bestReviews, id: \.self) { review in
                        ReviewReadView(reviewReadViewModel: ReviewReadViewModel(review: review))
                            .padding(5)
                            .cornerRadius(10)
                    }
                }
                .background(Color(UIColor.systemGray6))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .scrollIndicators(.never)
        
    }
}

struct DetailHeaderView: View {
    @ObservedObject var detailsViewModel: DetailsViewModel
    @State var isWritingReview = false
    var formattedGrade: String {
        return String(format: "%.1f", detailsViewModel.gradeAvg)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 2.0) {
                Spacer()
                ForEach(detailsViewModel.bestReviews.prefix(4), id: \.self) { review in
                    RestaurantImageView(url: review.imageUrls.first ?? "")
                }
                Spacer()
            }
    
            Spacer()
                .frame(height: 20)
            
            HStack {
                VStack(alignment: .leading) {
                    // 식당 이름
                    Text(detailsViewModel.info.placeName)
                        .font(.title2)
                    
//                    Text("조회수 및 즐겨찾기")
//                        .font(.caption)
                }
                
                // 평점
                Text(formattedGrade)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .foregroundColor(.dangoBrown)
            }
            .padding(.horizontal)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            
            Divider()
            
            HStack {
                Spacer()
                Button(action: {
                    detailsViewModel.registerFavorite()
                }, label: {
                    Text("가고싶다")
                    .foregroundStyle(.dangoBrown)
                })
                .frame(height: 60)
                
                Spacer()
                
                Button(action: {}, label: {
                    Text("가봤어요")
                    .foregroundStyle(.dangoBrown)
                })
                .frame(height: 60)
                
                Spacer()
                
                Button(action: {
                    self.isWritingReview.toggle()
                }, label: {
                    Text("리뷰쓰기")
                    .foregroundStyle(.dangoBrown)
                })
                .sheet(isPresented: $isWritingReview) {
                    ReviewWriteView(reviewWriteViewModel: ReviewWriteViewModel(shopId: UInt(detailsViewModel.info.id)!))
                }
                .frame(height: 60)
                Spacer()
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center)
            
        }
        .frame(alignment: .topLeading)
    }
}

struct MapView: View {
    @ObservedObject var mapViewModel: MapViewModel
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text(mapViewModel.restaurantAddress)
                    .font(.callout)
                    .bold()
            }
            .padding([.top, .leading])
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .topLeading)
            
            // 지도
            Map(coordinateRegion: $mapViewModel.region, annotationItems: mapViewModel.annotations) { item in
                MapMarker(coordinate: item.location, tint: item.color)
            }
                .frame(height: 100)
                .padding()
        }
    }
}

struct RestaurantImageView: View {
    var url: String
    
    var body: some View {
        AsyncImage(url: URL(string: url)) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 150)
            } 
        }
    }
}

#Preview {
    DetailsView(detailsViewModel: DetailsViewModel(info: DummyData.createDummyList(capacity: 1).first!))
}
