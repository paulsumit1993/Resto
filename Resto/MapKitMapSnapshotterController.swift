import MapKit

protocol MapSnapshotter {
    init(lat: Double, lon: Double)
    func start(completionHandler: @escaping ((UIImage) -> Void))
}

final class MapKitMapSnapshotterController: MKMapSnapshotter, MapSnapshotter {
    init(lat: Double, lon: Double) {
        let coordinates = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        let snapShotOptions = MKMapSnapshotter.Options()
        snapShotOptions.size = CGSize(width: 200, height: 200)
        snapShotOptions.mapType = .standard
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        snapShotOptions.region = MKCoordinateRegion(center: coordinates, span: span)
        super.init(options: snapShotOptions)
    }

    func start(completionHandler: @escaping ((UIImage) -> Void)) {
        start() { (snapshot, error) in
            DispatchQueue.main.async {
                if let image = snapshot?.image {
                    completionHandler(image)
                }
            }
        }
    }
}
