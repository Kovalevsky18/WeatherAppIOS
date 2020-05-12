import Foundation
import CoreLocation
class LocationManager:NSObject{
    static let shared = LocationManager()
    override init() {}
    var locationManager = CLLocationManager()
    var location:CLLocationCoordinate2D?

 func startLocation() {
         locationManager.requestWhenInUseAuthorization()
         locationManager.requestAlwaysAuthorization()
         if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
             locationManager.desiredAccuracy = kCLLocationAccuracyBest
             locationManager.requestAlwaysAuthorization()
             locationManager.startUpdatingLocation()
         }
     }
        
}
extension LocationManager : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        location = locValue
    }
}
