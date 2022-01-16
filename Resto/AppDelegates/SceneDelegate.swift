//
//  SceneDelegate.swift
//  Resto
//
//  Created by Sumit Paul on 16/01/22.
//

import MapKit
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)

        let locationManager = CLLocationManager()
        let locationService = CurrentLocationService(locationManager: locationManager)
        let poiService = TomTomPointOfInterestService()
        let viewModel = RestaurantsListViewModel(locationService: locationService, pointOfInterestService: poiService)
        let viewController = RestaurantsListViewController(viewModel: viewModel)
        let navigation = UINavigationController(rootViewController: viewController)

        viewController.didSelectPointOfInterest = { pointOfInterest in
            if let lat = pointOfInterest.position.lat,
                let lon = pointOfInterest.position.lon {
                let mapSnapshotter = MapKitMapSnapshotterController(lat: lat, lon: lon)
                let detailViewModel = RestaurantDetailViewModel(pointOfinterest: pointOfInterest, mapSnapshotController: mapSnapshotter)
                let detailViewController = RestaurantDetailViewController(viewModel: detailViewModel)
                navigation.pushViewController(detailViewController, animated: true)
            }
        }

        window.rootViewController = navigation
        self.window = window
        window.makeKeyAndVisible()
    }
}

