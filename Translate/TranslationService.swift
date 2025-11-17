/*import Foundation
import Translation

/// Simple wrapper around Apple's Translation framework.
/// Responsible for performing translations and exposing the result.
@MainActor
class TranslationService: ObservableObject {

    /// Last translated text shown in the UI.
    @Published var translatedText: String = ""

    /// Perform a one-shot translation using language codes, e.g. "en", "es", "fr".
    func translate(text: String, from fromCode: String, to toCode: String) async {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            translatedText = ""
            return
        }

        let sourceLanguage = Locale.Language(identifier: fromCode)
        let targetLanguage = Locale.Language(identifier: toCode)

        do {
            // Configure a TranslationSession for the requested languages
            let configuration = TranslationSession.Configuration(
                source: sourceLanguage,
                target: targetLanguage
            )

            let session = try TranslationSession(configuration: configuration)

            // Run translation
            let response = try await session.translate(trimmed)

            // Update for UI
            translatedText = response.targetText

        } catch {
            translatedText = "Translation failed: \(error.localizedDescription)"
        }
    }
}*/
