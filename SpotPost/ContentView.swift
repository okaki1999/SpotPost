import SwiftUI
import CoreLocation

struct ContentView: View {
    @State private var currentLocation: CLLocation? = nil
    @State private var locationText: String = "位置情報が未取得です" // 画面に表示するテキスト

    var body: some View {
        VStack(spacing: 20) {
            Text(locationText) // 位置情報を表示するテキスト
                .font(.title2)
                .multilineTextAlignment(.center)
                .padding()

            Button(action: {
                fetchLocation()
            }) {
                Text("位置情報を取得")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .padding()
    }

    // 位置情報を取得する関数
    private func fetchLocation() {
        LocationHelper.shared.requestLocation { location in
            self.currentLocation = location
            self.locationText = "緯度: \(location.coordinate.latitude)\n経度: \(location.coordinate.longitude)"
        }
    }
}

#Preview {
    ContentView()
}
