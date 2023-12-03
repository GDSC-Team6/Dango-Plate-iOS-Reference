//
//  EditProfileView.swift
//  DangoPlate
//
//  Created by 김정원 on 12/1/23.
//

import SwiftUI
import Alamofire

struct EditProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var editProfileViewModel = MyPageViewModel()
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("개인 정보").font(.headline)) {
                    HStack {
                        Text("이름")
                        Spacer()
                        TextField("\(editProfileViewModel.username)", text: $editProfileViewModel.username)
                            .keyboardType(.default)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    DatePicker("생년월일", selection: $editProfileViewModel.birthDate, displayedComponents: .date)
                    
                    HStack {
                        Text("전화번호")
                        Spacer()
                        TextField("\(editProfileViewModel.phoneNumber)", text: $editProfileViewModel.phoneNumber)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                    }
                }
            }
            .listStyle(GroupedListStyle())
        }
        .navigationBarTitle("내 정보 수정", displayMode: .inline)
        .navigationBarItems(trailing: Button("완료") {
            DispatchQueue.main.async {
                updateUserProfile()
                editProfileViewModel.fetchUserData()
                self.presentationMode.wrappedValue.dismiss()
                editProfileViewModel.saveProfile()
            }
        })
        
    }
    func updateUserProfile() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // 서버에서 요구하는 날짜 형식으로 설정
        let birthDateString = dateFormatter.string(from: editProfileViewModel.birthDate)
        
        let parameters: Parameters = [
            "birth": birthDateString,
            "name": editProfileViewModel.username,
            "phone": editProfileViewModel.phoneNumber
        ]
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(getATK())"
        ]
        
        AF.request(API.URL + "/user", method: .patch, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                print("Profile Updated: \(value)")
                // 성공 처리 로직
            case .failure(let error):
                print("Error: \(error)")
                // 실패 처리 로직
            }
        }
    }
}
#Preview {
    EditProfileView()
}
