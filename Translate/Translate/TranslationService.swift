import Foundation
import Combine

@MainActor
final class TranslationService: ObservableObject {
    /// Latest translated text to show in the UI
    @Published var translatedText: String = ""
}
