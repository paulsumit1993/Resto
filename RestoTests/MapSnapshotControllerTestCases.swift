//
//  MapSnapshotControllerTestCases.swift
//  RestoTests
//
//  Created by Sumit Paul on 16/01/22.
//

import MapKit
import XCTest

@testable import Resto

class MapSnapshotControllerTestCases: XCTestCase {
    func testMapSnapshotService() {
        var imageToTest: UIImage?
        let sut = MockMapSnapshotter(lat: 40.7128, lon: -74.0060)
        let expectation = expectation(description: "Load map snapshot")
        sut.start { image in
            imageToTest = image
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
        XCTAssertNotNil(imageToTest)
    }
}
