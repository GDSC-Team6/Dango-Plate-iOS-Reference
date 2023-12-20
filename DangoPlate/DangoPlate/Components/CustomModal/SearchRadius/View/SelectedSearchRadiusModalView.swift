//
//  CustomModalView.swift
//  DangoPlate
//
//  Created by Jinyoung Yoo on 11/28/23.
//

import SwiftUI

struct SelectedSearchRadiusModalView: View {
    @ObservedObject var restaurantGridViewModel: RestaurantGridViewModel
    @Binding var showModal: Bool

    var body: some View {
        VStack {
            transparentView()
            SelectSearchRadiusModalView(restaurantGridViewModel: restaurantGridViewModel, showModal: $showModal)
        }
        .ignoresSafeArea()
    }
    
    private func transparentView() -> some View {
        return (
            Rectangle()
            .ignoresSafeArea()
            .opacity(0.5)
        )
    }
}

private struct SelectSearchRadiusModalView : View {
    @EnvironmentObject private var pathModel: PathModel
    @ObservedObject var restaurantGridViewModel: RestaurantGridViewModel
    @Binding var showModal: Bool
    @State var sliderValue: Double = 0.5

    private var searchRadius: SearchRadius {
        switch sliderValue {
        case 0..<0.2:
            return .narrow(100, "100m")
        case 0.2..<0.4:
            return .mediumNarrow(300, "300m")
        case 0.4..<0.6:
            return .medium(500, "500m")
        case 0.6..<0.8:
            return .mediumWide(1000, "1km")
        default:
            return .wide(3000, "3km")
        }
    }

    private var selectedRadius: String {
        switch searchRadius {
        case .narrow(_, let expression):
            return expression
        case .mediumNarrow(_, let expression):
            return expression
        case .medium(_, let expression):
            return expression
        case .mediumWide(_, let expression):
            return expression
        case .wide(_, let expression):
            return expression
        }
    }
}

extension SelectSearchRadiusModalView {
    fileprivate var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.white)
                .frame(height: 180)
            
            VStack {
                HStack {
                    Button(action: {
                        restaurantGridViewModel.applySearchRadius(searchRadius)
                        showModal.toggle()
                    }, label: {
                        Image(systemName: "chevron.down")
                            .renderingMode(.template)
                            .foregroundStyle(.basicGray)
                            .font(.title2)
                    })
                    Spacer()
                }
                .padding(.leading, 10)
                .padding(.top, 5)
                
                VStack {
                    Text("내 위치에서 검색 반경 선택")
                        .foregroundStyle(.dangoBrown)
                        .font(.subheadline)
                    Text(selectedRadius)
                        .foregroundStyle(.dangoBrown)
                        .font(.largeTitle)
                        .padding(.top, 5)
                }
                
                Slider(value: $sliderValue)
                    .padding(.horizontal)
                    .padding(.bottom)
                    .accentColor(.dangoBrown)
            }
        }
    }
}

#Preview {
    SelectedSearchRadiusModalView(restaurantGridViewModel: RestaurantGridViewModel.init(searchType: .nearyBy), showModal: Binding<Bool>.constant(false))
}
