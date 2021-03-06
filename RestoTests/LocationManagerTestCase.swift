//
//  LocationManagerTestCase.swift
//  RestoTests
//
//  Created by Sumit Paul on 16/01/22.
//

import MapKit
import XCTest

@testable import Resto

class LocationManagerTestCase: XCTestCase {

    func testLocationManager() {
        let sut = MockLocationManager()
        XCTAssertEqual(sut.authorizationStatus, .authorizedWhenInUse)
        XCTAssertTrue(sut.isLocationServicesEnabled())
        XCTAssertEqual(sut.location, CLLocation(latitude: 40.7128, longitude: -74.0060))
    }
}
