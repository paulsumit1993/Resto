//
//  RestaurantsListViewModelTests.swift
//  RestoTests
//
//  Created by Sumit Paul on 16/01/22.
//

import XCTest

@testable import Resto

class RestaurantsListViewModelTests: XCTestCase {
    private var sut: RestaurantsListViewModel!
    override func setUp() {
        let mockLocationManager = MockLocationManager()
        let locationService = CurrentLocationService(locationManager: mockLocationManager)
        let poiService = PointOfInterestService()
        sut = RestaurantsListViewModel(locationService: locationService, pointOfInterestService: poiService)
    }

    func testStepValue() {
        XCTAssertEqual(sut.getStepValue(for: 150), 100)
        XCTAssertNotEqual(sut.getStepValue(for: 750), 500)
        XCTAssertEqual(sut.getStepValue(for: 1400), 1000)
        XCTAssertEqual(sut.getStepValue(for: 3000), 2000)
        XCTAssertNotEqual(sut.getStepValue(for: 120000), 10000)
    }

    func testStepValueInKm() {
        var measurement = Measurement(value: 0.1, unit: UnitLength.kilometers)
        XCTAssertEqual(sut.getStepValueinKM(for: 100), measurement)
        measurement = Measurement(value: 7, unit: UnitLength.kilometers)
        XCTAssertNotEqual(sut.getStepValueinKM(for: 750), measurement)
        measurement = Measurement(value: 14, unit: UnitLength.kilometers)
        XCTAssertEqual(sut.getStepValueinKM(for: 14000), measurement)
    }

    func testMinMaxStepValues() {
        XCTAssertEqual(sut.minimumStepValue, 100.0)
        XCTAssertEqual(sut.maximumStepValue, 100000.0)
    }
}
