//
//  Write.swift
//  DangoPlate
//
//  Created by Demian on 2023/11/29.
//

import SwiftUI
import Photos
import PhotosUI

struct ReviewWriteView: View {
    @ObservedObject var reviewWriteViewModel: ReviewWriteViewModel
    @State var showImagePicker: Bool = true

    var body: some View {
        VStack {
            HStack() {
                RatingButton(title: "맛있다", isSelected:
                                reviewWriteViewModel.selectedRating == 5) {
                    reviewWriteViewModel.selectedRating = 5
                }
                RatingButton(title: "괜찮다", isSelected:
                                reviewWriteViewModel.selectedRating == 3) {
                    reviewWriteViewModel.selectedRating = 3
                }
                RatingButton(title: "별로", isSelected:
                                reviewWriteViewModel.selectedRating == 1) {
                    reviewWriteViewModel.selectedRating = 1
                }
            }
            .padding(.horizontal, 5)
            
            Divider()
            
            TextEditor(text: $reviewWriteViewModel.contentText)
                .padding(10)
                .background(Color(UIColor.systemGray6))
                .cornerRadius(10)
            
            Divider()
            
            Button(action: {
                reviewWriteViewModel.postReview()
            }) {
                Text("입력 완료")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(reviewWriteViewModel.selectedRating != nil && !reviewWriteViewModel.contentText.isEmpty ? Color.green : Color.gray)
                    .cornerRadius(10)
            }
            .padding()
            .disabled(reviewWriteViewModel.selectedRating == nil || reviewWriteViewModel.contentText.isEmpty)
        }
        .navigationBarTitle("Your View")
        .sheet(isPresented: $showImagePicker, content: {
            PhotoPicker(images: $reviewWriteViewModel.images, selectionLimit: 5)
        })
    }
}

struct RatingButton: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundColor(isSelected ? .white : .black)
                .padding()
                .frame(maxWidth: .infinity)
                .background(isSelected ? Color.dangoBrown : Color(UIColor.systemGray4))
                .cornerRadius(10)
        }
        .buttonStyle(PlainButtonStyle())
        .padding()
    }
}

#Preview {
    ReviewWriteView(reviewWriteViewModel: ReviewWriteViewModel(shopId: 1139647183))
}
