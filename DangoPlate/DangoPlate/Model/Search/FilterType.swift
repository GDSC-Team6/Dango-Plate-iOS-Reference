//
//  FilterType.swift
//  DangoPlate
//
//  Created by Jinyoung Yoo on 10/25/23.
//

import Foundation

enum FilterType {
    enum Category: String {
        case all = "전체", wishToGo = "가고싶다"
    }
    
    enum FoodType: String, Identifiable, CaseIterable {
        case none = "선택 안함", korean = "한식", japanese = "일식", chinese = "중식", western = "양식",
             cafe = "카페", pub = "주점"
        var id: Self { self }
    }
}
