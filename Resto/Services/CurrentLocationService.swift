//
//  CurrentLocationService.swift
//  Resto
//
//  Created by Sumit Paul on 16/01/22.
//

import CoreLocation

protocol LocationManager {
    var location: CLLocation? { get }
    var delegate: CLLocationManagerDelegate? { get set }
    var authorizationStatus: CLAuthorizationStatus { get }

    func requestWhenInUseAuthorization()
    func requestLocation()
    func isLocationServicesEnabled() -> Bool
}

extension CLLocationManager: LocationManager {
    func isLocationServicesEnabled() -> Bool {
        return CLLocationManager.locationServicesEnabled()
    }
}

final class CurrentLocationService: NSObject, CLLocationManagerDelegate {
    private var locationManager: LocationManager
    var locationDidUpdate: ((CLLocationCoordinate2D) -> Void)?
    var latestCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060) // Setting default coordinate to NYC
    init(locationManager: LocationManager) {
        self.locationManager = locationManager
        super.init()
        self.locationManager.delegate = self
    }

    func requestAccess() {
        let authStatus: CLAuthorizationStatus = getAuthorizationStatus
        if authStatus == .denied || authStatus == .restricted {
            return
        }
        if authStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
            return
        }
    }

    func requestLocation() {
        if isAuthorized {
            locationManager.requestLocation()
        }
    }

    var isAuthorized: Bool {
        getAuthorizationStatus == .authorizedAlways || getAuthorizationStatus == .authorizedWhenInUse
    }

    var isLocationServicesEnabled: Bool {
        CLLocationManager.locationServicesEnabled()
    }

    var getAuthorizationStatus: CLAuthorizationStatus {
        locationManager.authorizationStatus
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if getAuthorizationStatus == .denied {
            locationDidUpdate?(latestCoordinate)
        } else {
            requestLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currentLocation = locations.last {
            latestCoordinate = currentLocation.coordinate
            locationDidUpdate?(currentLocation.coordinate)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) { }
}
