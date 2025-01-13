import SwiftUI
import CoreLocation

struct AddPostView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var postContent: String = ""
    @ObservedObject var postManager: PostManager
    @State private var currentLocation: CLLocation? = nil

    var body: some View {
        VStack {
            Text("Create a Post")
                .font(.title)

            TextField("Enter your post...", text: $postContent)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Post") {
                if let location = currentLocation {
                    postManager.addPost(content: postContent, location: location)
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .padding()
            .disabled(postContent.isEmpty)
            if currentLocation == nil {
                Text("にるでした")
                Text("aaa \(currentLocation)")
            }else{
                Text("にるじゃない！")
            }


            
            Button("閉じる") {
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
        }
        .padding()
        .onAppear {
            LocationHelper.shared.requestLocation { location in
                self.currentLocation = location
                print("Current Location in AddPostView: \(location.coordinate.latitude), \(location.coordinate.longitude)")
            }
        }
    }
}
