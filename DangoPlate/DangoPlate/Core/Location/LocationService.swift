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


class LocationService: ObservableObject {
    @Published var latitude: String = ""
    @Published var longitude: String = ""
    
    private var locationManager: CLLocationManager {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        return manager
    }
}

extension LocationService {
    
    static func createLocationService() -> LocationService {
        let locationService = LocationService()
        locationService.requestUserLocation()
        
        return locationService
    }
    
    func requestUserLocation() {
        guard let userLocation = locationManager.location?.coordinate else {
            self.latitude = "37.4862"
            self.longitude = "126.8023"
            return
        }
        
        self.latitude = String(userLocation.latitude)
        self.longitude = String(userLocation.longitude)
    }
}
