//
//  EditProfileView.swift
//  DangoPlate
//
//  Created by 김정원 on 12/1/23.
//

import SwiftUI
import Alamofire

struct EditProfileView: View {
    @State private var name: String = UserDefaults.standard.string(forKey: "userName") ?? ""
    @State private var birthDate: Date = UserDefaults.standard.object(forKey: "birthDate") as? Date ?? Date()
    @State private var phoneNumber: String = UserDefaults.standard.string(forKey: "phoneNumber") ?? ""
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var loginManager : ProfileHeaderViewModel
    func saveProfile() {
        UserDefaults.standard.set(name, forKey: "")
        UserDefaults.standard.set(birthDate, forKey: "birthDate")
        UserDefaults.standard.set(phoneNumber, forKey: "phoneNumber")
        // UserDefaults에 저장 후 필요한 작업 수행, 예를 들어 화면을 닫는다든지, 성공 메시지를 표시한다든지 등
    }
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("개인 정보").font(.headline)) {
                    HStack {
                        Text("이름")
                        Spacer()
                        TextField("\(name)", text: $name)
                            .keyboardType(.default)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    DatePicker("생년월일", selection: $birthDate, displayedComponents: .date)
                    
                    HStack {
                        Text("전화번호")
                        Spacer()
                        TextField("\(phoneNumber)", text: $phoneNumber)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                    }
                }
            }
            .listStyle(GroupedListStyle())
        }
        .navigationBarTitle("내 정보 수정", displayMode: .inline)
        .navigationBarItems(trailing: Button("완료") {
            updateUserProfile()
            
        })
    }
    func updateUserProfile() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // 서버에서 요구하는 날짜 형식으로 설정
        let birthDateString = dateFormatter.string(from: birthDate)
        
        let parameters: Parameters = [
            "birth": birthDateString,
            "name": name,
            "phone": phoneNumber
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
