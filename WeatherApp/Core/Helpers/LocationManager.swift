//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Osman Ahmed on 09/09/2022.
//

import CoreLocation
import Foundation

// MARK: - LocationManagerProtocol

protocol LocationManagerProtocol {
    func permissionChanged()
}

// MARK: - LocationManager

class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    static let shared = LocationManager()
    private let manager = CLLocationManager()
    var delegate: LocationManagerProtocol?
    @Published var lastKnownLocation: CLLocation?

    func startUpdating() {
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        
    }

    func locationManager(_: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus)
    {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:

            delegate?.permissionChanged()

        default:
            break
        }
    }
}
