//
//  MapViewModel.swift
//  DangoPlate
//
//  Created by Demian on 2023/12/12.
//

import Foundation
import CoreLocation
import MapKit
import SwiftUI

struct MapAnnotation: Identifiable {
    var id = UUID()
    var location: CLLocationCoordinate2D
    var color: Color
}

class MapViewModel: ObservableObject {
    @Published var userLocation: CLLocationCoordinate2D?
    @Published var restaurantLocation: CLLocationCoordinate2D
    @Published var region: MKCoordinateRegion
    @Published var annotations: [MapAnnotation]
    @Published var restaurantAddress: String
    
    init(restaurant: Restaurant) {
        let newLocation = CLLocationCoordinate2D(latitude: Double(restaurant.latitude)!, longitude: Double(restaurant.longitude)!)
        restaurantLocation = newLocation
        restaurantAddress = restaurant.address
        annotations = [MapAnnotation(location: newLocation, color: Color.dangoBrown)]
        
        region = MKCoordinateRegion(center: newLocation, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    }
}
