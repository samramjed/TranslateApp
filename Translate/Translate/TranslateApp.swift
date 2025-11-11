import SwiftUI

@main
struct TranslateApp: App {
    //@StateObject private var translationService = TranslationService()

    var body: some Scene {
        WindowGroup {
            RootView()
                //.environmentObject(translationService)
        }
    }
}
