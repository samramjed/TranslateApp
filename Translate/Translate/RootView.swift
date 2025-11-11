import SwiftUI

struct RootView: View {
    var body: some View {
        TabView {
            TranslateView()
                .tabItem {
                    Image(systemName: "character.bubble.fill")
                    Text("Translate")
                }

            CameraTranslatePlaceholderView()
                .tabItem {
                    Image(systemName: "camera.viewfinder")
                    Text("Camera")
                }

            ConversationPlaceholderView()
                .tabItem {
                    Image(systemName: "person.2.fill")
                    Text("Conversation")
                }
        }
    }
}

#Preview {
    RootView()
}
