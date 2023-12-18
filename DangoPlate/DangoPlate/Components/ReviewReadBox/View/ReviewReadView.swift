//
//  ReviewReadView.swift
//  DangoPlate
//
//  Created by Demian on 2023/11/29.
//

import SwiftUI

struct ReviewReadView: View {
    @ObservedObject var reviewReadViewModel: ReviewReadViewModel
    @State var isPreview = true
    
    var gradeToText: String {
        switch (reviewReadViewModel.review.grade) {
        case 1:
            return "별로다"
        case 5:
            return "맛있다"
        default:
            return "괜찮다"
        }
    }
    
    var gradeToColor: Color {
        switch (reviewReadViewModel.review.grade) {
        case 1:
            return .red
        case 5:
            return .blue
        default:
            return .green
        }
    }
    
    var body: some View {
        VStack(spacing: 5) {
            HStack {
                ProfileImage(imageUrl: reviewReadViewModel.review.userInfo.profileUrl)
                
                VStack (alignment: .leading) {
                    Text(reviewReadViewModel.review.userInfo.name) // 유저 정보 필요
                        .font(.callout)
                        .frame(alignment: .leading)
//                    Text("작성글 / 팔로워")   // 얘도 필요
//                        .font(.caption)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                Text(gradeToText) // 얘도 필요
                    .padding()
                    .foregroundColor(gradeToColor)
            }
            .frame(height: 60)
            
            Text(reviewReadViewModel.review.content)
                .lineLimit(isPreview ? 4 : 0)
            .frame(alignment: .leading)
            .multilineTextAlignment(.leading)
            
            // 이미지
            SwipeableView(images: reviewReadViewModel.review.imageUrls)
            
        }
        .background(.white)
//        .padding()
        .cornerRadius(10)
    }
}

struct ProfileImage: View {
    let imageUrl: String
    
    var body: some View {
        AsyncImage(url: URL(string: imageUrl)) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 50)
            } else {
                ProgressView()
                    .frame(height: 50)
            }
        }
        .clipShape(Circle())
    }
}

struct SwipeableView: View {
    let images: [String]
    @State private var currentIndex = 0

    var body: some View {
        ZStack {
            ForEach(images, id: \.self) { imageUrl in
                AsyncImage(url: URL(string: imageUrl)) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFill()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: UIScreen.main.bounds.height * 0.22)
                            .clipped()
                            .offset(x: CGFloat(self.images.firstIndex(of: imageUrl)! - self.currentIndex) * UIScreen.main.bounds.width)
                    }
                }
            }
        }
        .gesture(
            DragGesture()
                .onEnded { gesture in
                    let screenWidth = UIScreen.main.bounds.width
                    let horizontalDrag = gesture.translation.width
                    
                    if horizontalDrag > screenWidth / 4 {
                        // 스와이프 오른쪽
                        self.currentIndex = max(self.currentIndex - 1, 0)
                    } else if horizontalDrag < -screenWidth / 4 {
                        // 스와이프 왼쪽
                        self.currentIndex = min(self.currentIndex + 1, self.images.count - 1)
                    }
                }
        )
    }
}
//
//#Preview {
//    ReviewReadView()
//}
