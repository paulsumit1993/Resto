//
//  AppDelegate.swift
//  Resto
//
//  Created by Sumit Paul on 16/01/22.
//

import Foundation

struct POIAPIResponse: Decodable {
    let results: [PointOfInterestInfo]
}

struct PointOfInterestInfo: Identifiable, Hashable, Codable {
    let id: String
    let type: String
    let poi: PointOfinterest
    let address: Address
    let position: Position
}

struct Address: Hashable, Codable {
    let streetNumber, streetName, municipalitySubdivision, municipality: String?
    let countrySecondarySubdivision, countrySubdivision, postalCode, countryCode: String?
    let country, freeformAddress, localName: String?
}

struct PointOfinterest: Hashable, Codable {
    let name: String?
    let phone: String?
    let url: String?
    let categories: [String]?
}

struct Position: Hashable, Codable {
    let lat, lon: Double?
}
