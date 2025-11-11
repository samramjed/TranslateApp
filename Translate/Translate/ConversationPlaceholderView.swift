import SwiftUI

struct ConversationPlaceholderView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Conversation")
                .font(.largeTitle)
                .bold()

            Text("Two-person live translation UI will go here later.")
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)

            Spacer()
        }
        .padding()
    }
}

