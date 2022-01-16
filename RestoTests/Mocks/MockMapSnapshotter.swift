//
//  MockMapSnapshotter.swift
//  RestoTests
//
//  Created by Sumit Paul on 16/01/22.
//

import MapKit

@testable import Resto

final class MockMapSnapshotter: MapSnapshotter {
    init(lat: Double, lon: Double) { }

    func start(completionHandler: @escaping ((UIImage) -> Void)) {
        completionHandler(UIImage())
    }
}
