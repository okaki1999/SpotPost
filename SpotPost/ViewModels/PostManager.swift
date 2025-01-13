import Foundation
import CoreLocation

class PostManager: ObservableObject {
    @Published private(set) var posts: [Post] = []
    
    private let storageKey = "SavedPosts"
    
    init() {
        loadPosts()
    }
    
    func addPost(content: String, location: CLLocation) { 
        let newPost = Post(content: content, location: location)
        posts.append(newPost)
        savePosts()
    }
    
    func getNearbyPosts(from location: CLLocation, within distance: Double) -> [Post] {
        return posts.filter { post in
            let postLocation = CLLocation(latitude: post.latitude, longitude: post.longitude)
            return postLocation.distance(from: location) <= distance
        }
    }
    
    private func savePosts() {
        if let data = try? JSONEncoder().encode(posts) {
            UserDefaults.standard.set(data, forKey: storageKey)
        }
    }
    
    private func loadPosts() {
        if let data = UserDefaults.standard.data(forKey: storageKey),
           let savedPosts = try? JSONDecoder().decode([Post].self, from: data) {
            posts = savedPosts
        }
    }
}
