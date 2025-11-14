import SwiftUI
import Translation

struct TranslateView: View {
    // MARK: - Dependencies
    @EnvironmentObject private var translationService: TranslationService

    // MARK: - Language & text state
    @State private var sourceLang: AppLanguage = .englishUS
    @State private var targetLang: AppLanguage = .spanishSpain
    @State private var sourceText: String = ""

    // MARK: - Translation state
    @State private var configuration: TranslationSession.Configuration?
    @State private var pendingText: String = ""      // snapshot of the text to translate
    @State private var isTranslating: Bool = false

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground).ignoresSafeArea()

            VStack(alignment: .leading, spacing: 16) {

                // ─── Top bar (favourites + ellipsis) ───────────────────────────────
                HStack {
                    Button {
                        // open favourites
                    } label: {
                        ZStack {
                            Circle()
                                .fill(Color(.systemBackground))
                                .frame(width: 36, height: 36)
                                .shadow(color: .black.opacity(0.06), radius: 2, x: 0, y: 1)

                            Image(systemName: "list.star")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.black)
                        }
                    }
                    .buttonStyle(.plain)

                    Spacer()

                    Button { } label: {
                        ZStack {
                            Circle()
                                .fill(Color(.systemBackground))
                                .frame(width: 36, height: 36)
                                .shadow(color: .black.opacity(0.06), radius: 2, x: 0, y: 1)

                            Image(systemName: "ellipsis")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.black)
                        }
                    }
                    .buttonStyle(.plain)
                }

                Text("Translate")
                    .font(.system(size: 34, weight: .bold))

                // ─── Main card ────────────────────────────────────────────────────
                ZStack {
                    RoundedRectangle(cornerRadius: 32, style: .continuous)
                        .fill(Color(.systemBackground))

                    GeometryReader { geo in
                        ZStack {
                            VStack(alignment: .leading, spacing: 18) {

                                // Top language row
                                HStack {
                                    Button {
                                        // open source language picker later
                                    } label: {
                                        HStack(spacing: 4) {
                                            Text(sourceLang.displayName)
                                                .font(.headline)
                                                .foregroundColor(.primary)
                                            Image(systemName: "chevron.down")
                                                .font(.caption2)
                                                .foregroundColor(.secondary)
                                        }
                                    }
                                    Spacer()
                                }

                                // Source text + mic
                                HStack(alignment: .top, spacing: 8) {
                                    ZStack(alignment: .topLeading) {
                                        if sourceText.isEmpty {
                                            Text("Enter text")
                                                .foregroundColor(Color(.systemGray4))
                                                .font(.system(size: 30))
                                                .padding(.top, 4)
                                        }

                                        TextEditor(text: $sourceText)
                                            .frame(minHeight: 90, maxHeight: 120)
                                            .font(.system(size: 30))
                                            .foregroundColor(.primary)
                                            .scrollContentBackground(.hidden)
                                            .padding(.top, -4)
                                    }

                                    Button {
                                        // mic later
                                    } label: {
                                        Image(systemName: "microphone")
                                            .font(.title2)
                                            .foregroundColor(.black)
                                    }
                                    .padding(.top, 6)
                                }

                                Spacer(minLength: 8)

                                // Bottom language row
                                HStack {
                                    Button {
                                        // open target picker later
                                    } label: {
                                        HStack(spacing: 4) {
                                            Text(targetLang.displayName)
                                                .font(.headline)
                                                .foregroundColor(Color(.systemTeal))
                                            Image(systemName: "chevron.down")
                                                .font(.caption2)
                                                .foregroundColor(Color(.systemTeal))
                                        }
                                    }
                                    Spacer()
                                }

                                // Translated text + mic
                                HStack(alignment: .top, spacing: 8) {
                                    let text = translationService.translatedText
                                    let hasTranslation = !text.isEmpty

                                    Text(hasTranslation ? text : "Introducir texto")
                                        .font(.system(size: 28, weight: .semibold))
                                        .foregroundColor(
                                            hasTranslation
                                            ? .primary
                                            : Color(.systemTeal).opacity(0.25)
                                        )
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.bottom, 4)

                                    Button {
                                        // playback / mic later
                                    } label: {
                                        Image(systemName: "microphone")
                                            .font(.title2)
                                            .foregroundColor(Color(.systemTeal))
                                    }
                                    .padding(.top, 6)
                                }
                            }
                            .padding(20)

                            // Center divider
                            Rectangle()
                                .fill(Color(.separator))
                                .frame(width: geo.size.width - 40, height: 0.5)
                                .position(x: geo.size.width / 2, y: geo.size.height / 2)

                            // Swap button
                            Button {
                                swap(&sourceLang, &targetLang)
                                swap(&sourceText, &translationService.translatedText)
                                triggerTranslation()
                            } label: {
                                ZStack {
                                    Circle()
                                        .fill(Color(.systemGroupedBackground))
                                        .frame(width: 44, height: 44)
                                    Image(systemName: "arrow.trianglehead.swap")
                                        .font(.body)
                                        .foregroundColor(Color(.systemTeal))
                                }
                            }
                            .position(x: geo.size.width / 2, y: geo.size.height / 2)
                        }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
                }
                .frame(maxWidth: .infinity)
                .frame(height: 360)

                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
        }

        // ─── Auto-translate triggers ─────────────────────────────────────────

        
        .onChange(of: sourceText) {
            triggerTranslation()
        }
        .onChange(of: sourceLang) {
            triggerTranslation()
        }
        .onChange(of: targetLang) {
            triggerTranslation()
        }

        // ─── Translation session (no installedSource initializer here!) ─────
        .translationTask(configuration) { session in
            await runTranslation(using: session)
        }
    }

    // MARK: - Translation helpers

    private func triggerTranslation() {
        let trimmed = sourceText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            translationService.translatedText = ""
            configuration = nil
            return
        }

        pendingText = trimmed

        // Invalidate previous session (if any) so translationTask re-runs
        configuration?.invalidate()

        configuration = TranslationSession.Configuration(
            source: nil,                         // let framework detect source
            target: targetLang.localeLanguage    // our AppLanguage → Locale.Language
        )
    }

    private func runTranslation(using session: TranslationSession) async {
        let text = pendingText
        guard !text.isEmpty else { return }

        do {
            // API on your SDK expects a String, not a Request
            let response = try await session.translate(text)

            await MainActor.run {
                translationService.translatedText = response.targetText
            }
        } catch {
            await MainActor.run {
                translationService.translatedText = "Translation failed: \(error.localizedDescription)"
            }
        }
    }

}
