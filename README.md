# Resto

Resto is a simple iOS app that runs on iOS 14+ and is a simple way to find and call/navigate to the best restaurants around you. 

It is written in Swift and uses Core Location and MapKit to power the experience. The architecture is MVVM where callback acts as the binding layer between the view model and view. Interaction and communication with frameworks like CoreLocation and MapKit are facilitated through multiple controllers/managers. The point of segregating functionality into multiple classes is to promote testability via mocks for example and make each class responsible for only one thing.

The UI is powered by UICollectionView and diffable datasource which eliminates the need for manual table view data management. A slider is a part of the list UI to allow the user to change the radius of the search with the current location being the center of the search. The restaurant data is provided by TomTom.

### Installation
* Navigate to Resto root folder.
* Open `Resto.xcodeproj`.
* Wait for the dependencies to be downloaded and resolved.
* `CMD + R` to build and run the project.
  
### Dependencies
* TomTom API
* MapKit
* CoreLocation
* SnapKit
  
### Enhancements
* Add Map interface with restaurants annotations overlay.
* Adding coordinator for flexible and scalable routing.
* On-demand location search.
* Add restaurant filters.
* Additional Unit and UITests.