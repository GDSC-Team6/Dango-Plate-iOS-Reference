//
//  MyPageViewModel.swift
//  DangoPlate
//
//  Created by Jinyoung Yoo on 10/10/23.
//

import Foundation
import KeychainAccess
import SwiftUI
import Alamofire
class MyPageViewModel : ObservableObject{
    static let shared = MyPageViewModel()
  
    @Published var profileImage: Image? = nil
    @Published var username: String = UserDefaults.standard.string(forKey: "userName") ?? ""
    @Published var birthDate: Date = UserDefaults.standard.object(forKey: "birthDate") as? Date ?? Date()
    @Published var phoneNumber: String = UserDefaults.standard.string(forKey: "phoneNumber") ?? ""
    
    
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
    func saveProfile() {
        UserDefaults.standard.set(username, forKey: "")
        UserDefaults.standard.set(birthDate, forKey: "birthDate")
        UserDefaults.standard.set(phoneNumber, forKey: "phoneNumber")
        
    }
}
