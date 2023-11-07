//
//  SearchViewModel.swift
//  DangoPlate
//
//  Created by Jinyoung Yoo on 10/10/23.
//

import Foundation
import Alamofire

class SearchViewModel: ObservableObject {
    @Published var query: String = ""
}

extension SearchViewModel {
    func requestSearchResults() -> [RestaurantBasicInfo] {
        let requestURL = "http://35.216.0.111:8080/map/search"
        let queryParam = ["query": query + " 맛집"]
        let headers: HTTPHeaders = [.accept("application/json")]
        
        var searchResultList = [RestaurantBasicInfo]()

        AF.request(requestURL, parameters: queryParam, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: SearchResultResponse.self) {
            response in
            switch response.result {
            case .success(let data):
                for document in data.documents {
                    let restaurant = RestaurantBasicInfo(place_name: document.place_name, address: document.address_name)
                    searchResultList.append(restaurant)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        return searchResultList
    }
}
