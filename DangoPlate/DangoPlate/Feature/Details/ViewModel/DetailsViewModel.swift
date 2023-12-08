//
//  DetailPageViewModel.swift
//  DangoPlate
//
//  Created by Demian on 2023/11/10.
//

import Foundation
import Alamofire

class DetailsViewModel: ObservableObject {
    @Published var info: Restaurant
    @Published var thumbnailUrls: [String] = []
    @Published var bestReviews: [Review] = []   // string?
    // 평점, 조회수
    
    init(info: Restaurant) {
        self.info = info
        loadDetails()
    }
}

extension DetailsViewModel {
    func loadDetails() {
        let requestURL = API.RESTAURANT_INFO
        let queryParam = ["shopUid": self.info.id]
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(getATK())",
            "Accept": "application/json"
        ]

        AF.request(requestURL, parameters: queryParam, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: DetailsResponse.self) {
            response in
            switch response.result {
            case .success(let body):
                print(body.data)
                self.thumbnailUrls = body.data.imageUrls
                for review in body.data.reviewIds {
//                    guard let reviewId = UInt(review) else {
//                        continue
//                    }
                    
                    guard let thisReview = self.loadBestReviews(reviewId: review) else {
                        continue
                    }
                    
                    self.bestReviews.append(thisReview)
                }
                
                print("tu \(self.thumbnailUrls.count)")
                print("br \(self.bestReviews.count)")
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func loadBestReviews(reviewId: UInt) -> Review? {
        let requestURL = API.REVIEW
        let queryParam = ["reviewId": reviewId]
        let headers: HTTPHeaders = [
            .authorization("Bearer \(getATK())"),
            .accept("application/json")
        ]
        var result: Review?
        
        AF.request(requestURL, parameters: queryParam, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: ReviewResponse.self) {
                response in
                switch response.result {
                case .success(let review):
                    guard case let (shopId?, userId?) =
                            (UInt(review.data.shopId), UInt(review.data.userId))
                    else {
                        result = nil
                        return
                    }
                    result = Review(
                        reviewId: reviewId,
                        shopId: shopId,
                        userId: userId,
                        content: review.data.content
                    )
                    
                case .failure(let error):
                    result = nil
                    print(error.localizedDescription)
                }
        }
        
        return result
    }
}
