import Foundation
import CoreLocation

class LocationHelper: NSObject, CLLocationManagerDelegate {
    static let shared = LocationHelper()
    private let locationManager = CLLocationManager()
    private var locationCallback: ((CLLocation) -> Void)?
    
    var currentLocation: CLLocation?
    
    private override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestLocation(callback: @escaping (CLLocation) -> Void) {
        self.locationCallback = callback
        let status = locationManager.authorizationStatus

        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization() 
        case .denied, .restricted:
            print("Location access denied or restricted")
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        @unknown default:
            break
        }
    }

    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        currentLocation = location
        locationCallback?(location)
        locationManager.stopUpdatingLocation()
        
        print("Location updated: \(location.coordinate.latitude), \(location.coordinate.longitude)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location Error: \(error.localizedDescription)")
    }
}
