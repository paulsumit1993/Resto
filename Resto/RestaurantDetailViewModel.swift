
import Foundation
import UIKit.UIImage

final class RestaurantDetailViewModel {
    enum Event {
        case getDirections
        case call
    }

    var didUpdateMapSnapshot: ((UIImage) -> Void)?
    private let pointOfinterest: PointOfInterestInfo
    private var mapSnapshotController: MapSnapshotter
    init(pointOfinterest: PointOfInterestInfo, mapSnapshotController: MapSnapshotter) {
        self.pointOfinterest = pointOfinterest
        self.mapSnapshotController = mapSnapshotController
        mapSnapshotController.start { [weak self] image in
            self?.didUpdateMapSnapshot?(image)
        }
    }

    var navigationTitle: String {
        pointOfinterest.poi.name ?? "Restaurant"
    }

    var address: String? {
        pointOfinterest.address.freeformAddress
    }

    var phoneNumber: String? {
        pointOfinterest.poi.phone?.components(separatedBy: .whitespaces).joined()
    }

    func dispatch(event: Event) {
        switch event {
        case .getDirections:
            if let lat = pointOfinterest.position.lat,
               let lon = pointOfinterest.position.lon,
                let url = URL(string: "http://maps.apple.com/?daddr=\(lat),\(lon)") {
                UIApplication.shared.open(url)
            }
        case .call:
            if let phoneNumber = phoneNumber,
                let url = URL(string: "tel://\(phoneNumber)") {
                UIApplication.shared.open(url)
            }
        }
    }
}
