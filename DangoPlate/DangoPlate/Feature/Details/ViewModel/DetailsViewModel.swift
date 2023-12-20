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
    @Published var gradeAvg: Double = 3
    
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
                self.gradeAvg = body.data.gradeAvg
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
                        imageUrls: review.data.urls,
                        userInfo: UserInfo(name: review.data.name, profileUrl: review.data.profileUrl),
                        grade: review.data.grade
                    ))
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    return
                }
        }
    }
    
    func registerFavorite() {
        let requestURL = "\(API.FAVORITE)/\(info.id)"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(getATK())",
            "Accept": "application/json"
        ]

        AF.request(requestURL, method: .post, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: CommonResponse.self) {
                response in
                print(String(data: response.data!, encoding: .utf8)!)
                switch response.result {
                case .success(_):
                    break
                case .failure(let error):
                    print("\(error.localizedDescription)")
                }
        }
    }
}
