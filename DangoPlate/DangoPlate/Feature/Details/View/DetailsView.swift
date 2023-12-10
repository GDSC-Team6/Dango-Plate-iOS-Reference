//
//  SwiftUIView.swift
//  DangoPlate
//
//  Created by Demian on 2023/11/02.
//

import SwiftUI
import MapKit

struct DetailsView: View {
    @ObservedObject var detailsViewModel: DetailsViewModel
    
    var body: some View {
        ScrollView {
            VStack( spacing: 8.0) {
                
                DetailHeaderView(detailsViewModel: detailsViewModel)
                Divider()
                MapView(
                    restaurantLatitude: detailsViewModel.info.latitude,
                    restaurantLongitude: detailsViewModel.info.longitude,
                    restaurantAddress: detailsViewModel.info.address
                )
                .padding(10)
                .cornerRadius(10)
                
                Divider()
                
                LazyVStack {
                    ForEach(detailsViewModel.bestReviews.prefix(3), id: \.self) { review in
                        ReviewReadView(reviewReadViewModel: ReviewReadViewModel(review: review))
                            .padding(5)
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
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 2.0) {
                Spacer()
                RestaurantImageView(url: detailsViewModel.thumbnailUrls.first ?? "")
                RestaurantImageView(url: detailsViewModel.thumbnailUrls.first ?? "")
                RestaurantImageView(url: detailsViewModel.thumbnailUrls.last ?? "")
                Spacer()
            }
    
            Spacer()
                .frame(height: 20)
            
            HStack {
                VStack(alignment: .leading) {
                    // 식당 이름
                    Text(detailsViewModel.info.placeName)
                        .font(.title)
                    
                    Text("조회수 및 즐겨찾기")
                        .font(.caption)
                }
                
                // 평점
                Text("4.5")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .foregroundColor(.dangoBrown)
            }
            .padding(.horizontal)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            
            Divider()
            
            HStack {
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("가고싶다")
                    .foregroundStyle(.dangoBrown)
                })
                .frame(width: 100, height: 80)
                
                
                Button(action: {}, label: {
                    Text("가봤어요")
                    .foregroundStyle(.dangoBrown)
                })
                .frame(width: 100, height: 80)
                
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("리뷰쓰기")
                    .foregroundStyle(.dangoBrown)
                })
                .frame(width: 100, height: 80)
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center)
            
        }
        .frame(alignment: .topLeading)
    }
}

struct MapView: View {
    let restaurantLatitude: String  // string?
    let restaurantLongitude: String // string?
    let restaurantAddress: String
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.5666791, longitude: 126.9782914), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text(restaurantAddress)
                    .font(.callout)
                    .bold()
            }
            .padding([.top, .leading])
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .topLeading)
            
            
            // 지도
            Spacer()
            Map(coordinateRegion: $region, showsUserLocation: true)
                .frame(height: 100)
                .padding([.top])
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
            } else if phase.error != nil {
                Text("Image not available")
                    .frame(height: 150)
            } else {
                ProgressView()
                    .frame(height: 150)
            }
        }
    }
}

#Preview {
    DetailsView(detailsViewModel: DetailsViewModel(info: DummyData.createDummyList(capacity: 1).first!))
}
