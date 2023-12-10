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

class ReviewWriteViewModel: ObservableObject {
    let shopId: UInt
    @Published var contentText: String = ""
    @Published var images: [UIImage] = []
    @Published var selectedRating: Int?
    
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
        
        var result = false
        
        AF.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
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
                print(r.code)
                result = true
            case .failure(let error):
                result = false
                print("\(error.localizedDescription)")
            }
        }
    
        return result
    }
}
