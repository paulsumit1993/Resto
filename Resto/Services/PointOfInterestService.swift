//
//  AppDelegate.swift
//  Resto
//
//  Created by Sumit Paul on 16/01/22.
//

import Foundation

protocol PointOfInterestService {
    func seachPointOfInterests(lat: String, lon: String, radiusInMetres: Float, completion: @escaping(Result<POIAPIResponse, Error>) -> Void)
}

final class TomTomPointOfInterestService: PointOfInterestService {
    private enum TOMTOMAPI {
        static let key = "ylEA72b3Z1NnqlxVoqPiHLPw0GunJ4rn"
        static var url: URL? {
            var components = URLComponents()
            components.scheme = "https"
            components.host = "api.tomtom.com"
            components.path = "/search/2/search/restaurant.json"
            return components.url
        }
    }

    func seachPointOfInterests(lat: String, lon: String, radiusInMetres: Float = 1000, completion: @escaping(Result<POIAPIResponse, Error>) -> Void) {
        let radiusInKM = "\(radiusInMetres * 1000)"
        let searchEndpoint = Endpoint<POIAPIResponse>(json: .get,
                                                      url: TOMTOMAPI.url!,
                                                   query: ["lat": lat,
                                                           "lon": lon,
                                                           "radius": radiusInKM,
                                                           "limit": "100",
                                                           "idxSet": "POI",
                                                           "key": TOMTOMAPI.key])
        URLSession.shared.load(searchEndpoint) { (result) in
            completion(result)
        }
    }
}
