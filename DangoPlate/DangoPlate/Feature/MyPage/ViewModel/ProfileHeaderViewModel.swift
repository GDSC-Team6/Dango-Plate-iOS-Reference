//
//  ProfileHeaderViewModel.swift
//  DangoPlate
//
//  Created by 김정원 on 12/1/23.
//

import Foundation
import SwiftUI
import Alamofire
class ProfileHeaderViewModel : ObservableObject {
    
    @Published var username: String = UserDefaults.standard.string(forKey: "userName") ?? " "
    @Published var profileImage: Image? = nil
    @EnvironmentObject var loginManager: LoginManager

    init(isPreview: Bool = false) {
            if isPreview {
                // Preview 데이터 로드
                self.username = "가솜"
                self.profileImage = Image(systemName: "person.circle")
            } else {
                // 실제 앱 데이터 로드
                self.fetchUserData()
            }
        }
    func fetchUserData() {
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(getATK())"
        ]
        
        AF.request("\(API.USER_DATA)", headers: headers).responseJSON { [weak self] response in
            switch response.result {
            case .success(let value):
                if let jsonDict = value as? [String: Any], let data = jsonDict["data"] as? [String: Any] {
                    let name = data["name"] as? String ?? "Unknown"
                    let imageUrl = data["imageUrl"] as? String ?? "person.fill"
                    
                    UserDefaults.standard.set(name, forKey: "userName")
                    UserDefaults.standard.set(imageUrl, forKey: "imageUrl")
                    
                    DispatchQueue.main.async {
                        self?.username = name
                        self?.loadImage(from: imageUrl)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        AF.download(url).responseData { [weak self] response in
            if let data = response.value, let uiImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.profileImage = Image(uiImage: uiImage)
                }
            }
        }
    }
    
    
}
