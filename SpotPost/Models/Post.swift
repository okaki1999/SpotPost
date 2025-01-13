import Foundation
import CoreLocation

struct Post: Identifiable, Codable {
    let id: UUID
    let content: String
    let latitude: Double
    let longitude: Double
    let timestamp: Date

    init(content: String, location: CLLocation) {
        self.id = UUID()
        self.content = content
        self.latitude = location.coordinate.latitude
        self.longitude = location.coordinate.longitude
        self.timestamp = Date()
    }
}
