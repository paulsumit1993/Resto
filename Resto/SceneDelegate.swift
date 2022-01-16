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
        let poiService = PointOfInterestService()
        let viewModel = RestaurantsListViewModel(locationService: locationService, pointOfInterestService: poiService)
        let viewController = RestaurantsListViewController(viewModel: viewModel)
        let navigation = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigation
        self.window = window
        window.makeKeyAndVisible()
    }
}

