//
//  ReviewWriteViewModel.swift
//  DangoPlate
//
//  Created by Demian on 2023/11/29.
//

import Foundation
import Alamofire
import Combine
import UIKit

struct ReviewObject: Codable {
    let grade: UInt
    let review_content: String
    let shop_uid: UInt
    
    enum CodingKeys: String, CodingKey {
            case grade, review_content, shop_uid
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(grade, forKey: .grade)
            try container.encode(review_content, forKey: .review_content)
            try container.encode(shop_uid, forKey: .shop_uid)
        }
}

class ReviewWriteViewModel: ObservableObject {
    let shopId: UInt
    @Published var contentText: String = ""
    @Published var images: [UIImage] = []
    @Published var selectedRating: UInt = 3
    
    init(shopId: UInt) {
        self.shopId = shopId
    }
}

extension ReviewWriteViewModel {
    func postReview() -> Bool {
        let requestURL = API.REVIEW
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(getATK())",
            "Accept": "application/json",
            "Content-Type" : "multipart/form-data"
        ]
        let parameters = [
            "review_content": contentText,
            "shop_uid": shopId
        ] as [String : Any]
        
        let review = ReviewObject(grade: selectedRating ?? 3, review_content: contentText, shop_uid: shopId)
        
        var result = false
        
        AF.upload(multipartFormData: { (multipartFormData) in
//            for (key, value) in parameters {
//                multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
//            }
            
            if let reviewData = try? JSONEncoder().encode(review) {
                print(reviewData)
                multipartFormData.append(reviewData, withName: "review")
            }
            
            for (index, image) in self.images.enumerated() {
                if let jpegImage = image.jpegData(compressionQuality: 0.5) {
                    multipartFormData.append(
                        jpegImage, withName: "images",
                        fileName: "image_\(index).jpg",
                        mimeType: "image/jpeg"
                        )
                }
            }
        }, to: requestURL, method: .post, headers: headers)
        .validate(statusCode: 200..<300)
        .responseDecodable(of: CommonResponse.self) { response in
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Server Response: \(utf8Text)")
            }
            switch response.result {
            case .success(let r):
                result = true
            case .failure(let error):
                result = false
                print("\(error.localizedDescription)")
            }
        }
    
        return result
    }
}
