//
//  PointOfInterestTestCase.swift
//  RestoTests
//
//  Created by Sumit Paul on 16/01/22.
//

import XCTest

@testable import Resto

class PointOfInterestTestCase: XCTestCase {
    private var sut: MockPointOfInterestService!

    override func setUp() {
        sut = MockPointOfInterestService()
    }

    func testPointOfInterestInfoModelEquality() throws {
        let poi = PointOfinterest(name: "Noma", phone: "+123", url: nil, categories: nil)
        let address = Address(streetNumber: nil, streetName: nil, municipalitySubdivision: nil, municipality: nil, countrySecondarySubdivision: nil, countrySubdivision: nil, postalCode: nil, countryCode: nil, country: "Netherlands", freeformAddress: nil, localName: "Amsterdam")
        let position = Position(lat: 0.0, lon: 0.0)
        let sut = PointOfInterestInfo(id: "123", type: "ssd", poi: poi, address: address, position: position)

        let encoder = JSONEncoder()
        let data = try encoder.encode(sut)

        let decoder = JSONDecoder()
        let decodedData = try decoder.decode(PointOfInterestInfo.self, from: data)
        XCTAssertEqual(sut, decodedData)
    }

    func testasas() {
        var apiResponse: POIAPIResponse?
        let expectation = expectation(description: "Load point of interest service data")
        sut.seachPointOfInterests(lat: "0.0", lon: "0.0") { result in
            if case let .success(response) = result {
                apiResponse = response
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 0.01)
        XCTAssertNotNil(apiResponse)
    }
}
