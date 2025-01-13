import SwiftUI
import CoreLocation

struct PostListView: View {
    @StateObject private var postManager = PostManager()
    @State private var currentLocation: CLLocation? = nil
    @State private var showAddPostView = false

    var body: some View {
        VStack {
            Text("Nearby Posts")
                .font(.title)
                .padding()

            if let location = currentLocation {
                List {
                    ForEach(postManager.getNearbyPosts(from: location, within: 10)) { post in
                        VStack(alignment: .leading) {
                            Text(post.content)
                                .font(.headline)
                            Text("\(post.timestamp, formatter: DateFormatter.short)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
            } else {
                Text("Fetching location...")
            }

            Button("ポストする") {
                showAddPostView = true
            }
            .padding()
            .sheet(isPresented: $showAddPostView) {
                AddPostView(postManager: postManager)
            }
        }
        .onAppear {
            LocationHelper.shared.requestLocation { location in
                self.currentLocation = location
            }
        }
    }
}
