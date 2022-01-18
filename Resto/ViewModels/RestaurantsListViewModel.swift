//
//  RestaurantsListViewModel.swift
//  Resto
//
//  Created by Sumit Paul on 16/01/22.
//

import Foundation

final class RestaurantsListViewModel {
    enum Event {
        case accessLocation
        case sliderDidChange(value: Float)
    }

    enum Action {
        case applySnapshot([PointOfInterestInfo])
        case loading(Bool)
    }

    var onAction: ((Action) -> Void)?
    let minimumStepValue: Float = 100.0
    let maximumStepValue: Float = 10000.0
    private let locationService: CurrentLocationService
    private let pointOfInterestService: PointOfInterestService
    private var previousStepValue: Float = 100.0
    init(locationService: CurrentLocationService, pointOfInterestService: PointOfInterestService) {
        self.locationService = locationService
        self.pointOfInterestService = pointOfInterestService
        setupBindings()
    }

    func dispatch(event: Event) {
        switch event {
        case .accessLocation:
            if locationService.isAuthorized {
                locationService.requestLocation()
            } else {
                locationService.requestAccess()
            }
        case let .sliderDidChange(value):
            if value != previousStepValue {
                previousStepValue = value
                fetchPointOfInterests(with: value)
            }
        }
    }

    func getStepValue(for value: Float) -> Float {
        switch value {
        case 100..<300:
            return 100
        case 300..<750:
            return 500
        case 750..<1500:
            return 1000
        case 1500..<3500:
            return 2000
        case 3500..<7500:
            return 5000
        case 7500...10000:
            return 10000
        default:
            return 0
        }
    }

    func getStepValueinKM(for value: Float) -> Measurement<UnitLength> {
        let distance = Measurement(value: Double(value), unit: UnitLength.meters)
        return distance.converted(to: UnitLength.kilometers)
    }

    private func setupBindings() {
        locationService.locationDidUpdate = { [weak self] coordinate in
            self?.fetchPointOfInterests()
        }
    }

    private func fetchPointOfInterests(with radius: Float = 1000)  {
        onAction?(.loading(true))
        let coordinate = locationService.latestCoordinate
        pointOfInterestService.seachPointOfInterests(lat: "\(coordinate.latitude)", lon: "\(coordinate.longitude)", radiusInMetres: radius) { [weak self] result in
            switch result {
            case .success(let response):
                self?.onAction?(.loading(false))
                self?.onAction?(.applySnapshot(response.results.shuffled())) // Adding shuffle to reorder items in the UI to reflect that the data is updating.
            case .failure(let error):
                self?.onAction?(.loading(false))
                print(error.localizedDescription)
            }
        }
    }
}
