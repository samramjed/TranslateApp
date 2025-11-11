import SwiftUI

struct RootView: View {
    var body: some View {
        TabView {
            TranslateView()
                .tabItem {
                    Image(systemName: "translate")
                    Text("Translate")
                }

            CameraTranslatePlaceholderView()
                .tabItem {
                    Image(systemName: "camera.fill")
                    Text("Camera")
                }

            ConversationPlaceholderView()
                .tabItem {
                    Image(systemName: "person.2.fill")
                    Text("Conversation")
                }
        }
        .tint(Color(.systemTeal))
    }
}

#Preview {
    RootView()
}
