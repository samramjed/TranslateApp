import SwiftUI

@main
struct TranslateApp: App {
    @StateObject private var translationService: TranslationService =
        {
            if #available(iOS 17.0, *) { return TranslationService() }
            // Fallback shim for older iOS (never used if your target is 17+)
            fatalError("Translation requires iOS 17.0+")
        }()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(translationService)
        }
    }
}
