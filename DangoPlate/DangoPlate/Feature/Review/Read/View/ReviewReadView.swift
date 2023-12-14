//
//  ReviewReadView.swift
//  DangoPlate
//
//  Created by Demian on 2023/11/29.
//

import SwiftUI

struct ReviewReadView: View {
    @ObservedObject var reviewReadViewModel: ReviewReadViewModel
    
    var body: some View {
        VStack(spacing: 5) {
            HStack {
                ProfileImage(imageUrl:  "https://image.bugsm.co.kr/album/images/200/200258/20025825.jpg?version=20210428040249.0")
                
                VStack (alignment: .leading) {
                    Text("닉네임") // 유저 정보 필요
                        .font(.callout)
                        .frame(alignment: .leading)
                    Text("작성글 / 팔로워")   // 얘도 필요
                        .font(.caption)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                Text("괜찮다") // 얘도 필요
            }
            .frame(height: 60)
            
            Text(reviewReadViewModel.review.content)
            .lineLimit(4)
            .frame(alignment: .leading)
            
            // 이미지
            SwipeableView(images: ["https://www.michaelfcollins3.me/posts/2021/01/creating-multiple-scenes-in-a-swiftui-app/multiple_scene_model.png",
                                  "https://www.michaelfcollins3.me/posts/2021/01/creating-multiple-scenes-in-a-swiftui-app/show_all_windows.jpeg"])
            
        }
        .background(.white)
        .padding()
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
            } else if phase.error != nil {
                Text("Image not available")
                    .frame(height: 20)
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
