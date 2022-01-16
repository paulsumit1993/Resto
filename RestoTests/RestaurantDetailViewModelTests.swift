//
//  RestaurantDetailViewModelTests.swift
//  RestoTests
//
//  Created by Sumit Paul on 16/01/22.
//

import XCTest

@testable import Resto

class RestaurantDetailViewModelTests: XCTestCase {
    private var sut: RestaurantDetailViewModel!
    private var poiInfo: PointOfInterestInfo!
    override func setUp() {
        poiInfo = getSamplePointOfInterestInfo()
        let mapSnapshotController = MockMapSnapshotter(lat: poiInfo.position.lat!, lon: poiInfo.position.lon!)
        sut = RestaurantDetailViewModel(pointOfinterest: poiInfo, mapSnapshotController: mapSnapshotController)
    }

    func testNavigationTitle() {
        XCTAssertEqual(sut.navigationTitle, poiInfo.poi.name)
    }

    func testPhoneNumber() {
        XCTAssertEqual(sut.phoneNumber, poiInfo.poi.phone)
    }

    func testAddress() {
        XCTAssertEqual(sut.address, poiInfo.address.freeformAddress)
    }

    private func getSamplePointOfInterestInfo() -> PointOfInterestInfo {
        let poi = PointOfinterest(name: "Noma", phone: "+123", url: nil, categories: nil)
        let address = Address(streetNumber: nil, streetName: nil, municipalitySubdivision: nil, municipality: nil, countrySecondarySubdivision: nil, countrySubdivision: nil, postalCode: nil, countryCode: nil, country: "Netherlands", freeformAddress: nil, localName: "Amsterdam")
        let position = Position(lat: 0.0, lon: 0.0)
        let poiInfo = PointOfInterestInfo(id: "123", type: "ssd", poi: poi, address: address, position: position)
        return poiInfo
    }
}
