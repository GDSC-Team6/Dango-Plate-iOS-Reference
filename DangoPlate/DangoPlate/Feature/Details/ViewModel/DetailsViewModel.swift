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
                self.thumbnailUrls = body.data.imageUrls
                for review in body.data.reviewIds {
                    self.loadBestReviews(reviewId: review)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func loadBestReviews(reviewId: UInt) {
        let requestURL = API.REVIEW
        let queryParam = ["reviewId": reviewId]
        let headers: HTTPHeaders = [
            .authorization("Bearer \(getATK())"),
            .accept("application/json")
        ]
        
        AF.request(requestURL, parameters: queryParam, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: ReviewResponse.self) {
                response in
                switch response.result {
                case .success(let review):
                    guard case let (shopId?, userId?) =
                            (UInt(review.data.shopId), UInt(review.data.userId))
                    else {
                        return
                    }
                    self.bestReviews.append(
                        Review(
                        reviewId: reviewId,
                        shopId: shopId,
                        userId: userId,
                        content: review.data.content,
                        imageUrls: review.data.urls
                    ))
                                       
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    return
                }
        }
    }
}
