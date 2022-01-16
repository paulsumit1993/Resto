//
//  MockPointOfInterestService.swift
//  RestoTests
//
//  Created by Sumit Paul on 16/01/22.
//

import Foundation

@testable import Resto

final class MockPointOfInterestService: PointOfInterestService {
    func seachPointOfInterests(lat: String, lon: String, radiusInMetres: Float = 1000, completion: @escaping(Result<POIAPIResponse, Error>) -> Void) {
        completion(.success(getSamplePointOfInterestInfoResponse()))
    }

    private func getSamplePointOfInterestInfoResponse() -> POIAPIResponse {
        let poi = PointOfinterest(name: "Noma", phone: "+123", url: nil, categories: nil)
        let address = Address(streetNumber: nil, streetName: nil, municipalitySubdivision: nil, municipality: nil, countrySecondarySubdivision: nil, countrySubdivision: nil, postalCode: nil, countryCode: nil, country: "Netherlands", freeformAddress: nil, localName: "Amsterdam")
        let position = Position(lat: 0.0, lon: 0.0)
        let poiInfo = PointOfInterestInfo(id: "123", type: "ssd", poi: poi, address: address, position: position)
        return POIAPIResponse(results: [poiInfo])
    }
}
