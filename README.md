# Resto

Resto is a simple iOS app which runs on iOS 14+ and is a simple way to find and call/navigate to the best restaurants around you. It is written in Swift and uses Core Location and MapKit to power the experience. The architecture is MVVM which callback acting as the binding layer between view model and view. Interaction and communcation with frameworks like CoreLocation and MapKit is facilitated through multiple controllers/managers. The UI is powered by UICollectionView and diffable datasource which eliminates the need for manual table view data management. A slider is a part of the list UI to allow the user to change the radius of search with the current location being the center of the search. The restaurant data is provided by TomTom.

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
* On demand location search.
* Add restaurant filters.
* Addtional Unit and UITests.