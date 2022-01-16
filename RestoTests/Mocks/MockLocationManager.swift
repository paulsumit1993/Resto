//
//  MockLocationManager.swift
//  RestoTests
//
//  Created by Sumit Paul on 16/01/22.
//

import MapKit

@testable import Resto

class MockLocationManager: LocationManager {
    var location: CLLocation? = CLLocation(
        latitude: 40.7128,
        longitude: -74.0060
    )

    var authorizationStatus: CLAuthorizationStatus {
        .authorizedWhenInUse
    }

    var delegate: CLLocationManagerDelegate?

    func requestWhenInUseAuthorization() { }
    func requestLocation() { }

    func isLocationServicesEnabled() -> Bool {
        return true
    }
}
