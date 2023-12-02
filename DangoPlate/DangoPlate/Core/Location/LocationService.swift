//
//  LocationViewModel.swift
//  DangoPlate
//
//  Created by Jinyoung Yoo on 11/22/23.
//

import CoreLocation

// TODO: - 위치 서비스 권한에 따라 권한 바꿔달라는 요청 보내기
// TODO: - 제일 처음 권한 요청일 때는 현재 위치를 못받아오는 문제 해결하기
// https://object-world.tistory.com/20

struct LocationService {
    static func requestUserLocation() -> (latitude: String, longitude: String) {
        let locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest

        locationManager.requestWhenInUseAuthorization()

        guard let userLocation = locationManager.location?.coordinate else {
            return (latitude: "37.4862", longitude: "126.8023")
        }
        
        return (latitude: String(userLocation.latitude), longitude: String(userLocation.longitude))
    }
}
