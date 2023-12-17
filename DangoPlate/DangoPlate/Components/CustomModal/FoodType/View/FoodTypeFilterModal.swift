//
//  FoodTypeFilterModal.swift
//  DangoPlate
//
//  Created by Jinyoung Yoo on 12/16/23.
//

import SwiftUI

struct FoodTypeFilterModal: View {
    @ObservedObject var restaurantGridViewModel: RestaurantGridViewModel
    @Binding var showModal: Bool

    var body: some View {
        ZStack {
            transparentView()
            SelectFoodTypeFilterModal(restaurantGridViewModel: restaurantGridViewModel, showModal: $showModal)
        }
        .ignoresSafeArea()
    }
    
    private func transparentView() -> some View {
        return (
            Rectangle()
            .ignoresSafeArea()
            .opacity(0.4)
        )
    }
}

private struct SelectFoodTypeFilterModal: View {
    @ObservedObject var restaurantGridViewModel: RestaurantGridViewModel
    @Binding var showModal: Bool
    @State private var foodType: FilterType.FoodType = .none

    var body: some View {
        VStack {
            Spacer()
            
            ZStack {
                Rectangle()
                    .frame(height: 400)
                    .foregroundStyle(.white)
                    .overlay(alignment: .top) {
                        VStack {
                            HeaderViewOfFilterModal(restaurantGridViewModel: restaurantGridViewModel, showModal: $showModal, foodType: $foodType)
                                .padding(.bottom, 20)
                            
                            Text("음식종류")
                                .font(.title2)
                            Picker(selection: $foodType, label: Text("FoodType")) {
                                ForEach(FilterType.FoodType.allCases) {
                                    Text($0.rawValue)
                                        .font(.title2)
                                }
                            }
                            .pickerStyle(.wheel)
                        }
                    }
            }
        }
    }
}

private struct HeaderViewOfFilterModal: View {
    @ObservedObject var restaurantGridViewModel: RestaurantGridViewModel
    @Binding var showModal: Bool
    @Binding var foodType: FilterType.FoodType
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(height: 50)
                .foregroundStyle(.ultraThickMaterial)
            
            HStack {
                Button(action: {
                    showModal.toggle()
                }, label: {
                    Text("취소")
                        .foregroundStyle(.black)
                })
                
                Spacer()
                
                Button(action: {
                    restaurantGridViewModel.applyFoodTypeFilter(foodType)
                    showModal.toggle()
                }, label: {
                    Text("필터 적용")
                        .foregroundStyle(.dangoBrown)
                })
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    FoodTypeFilterModal(restaurantGridViewModel: RestaurantGridViewModel(searchType: .nearyBy),
        showModal: Binding<Bool>.constant(false))
}
