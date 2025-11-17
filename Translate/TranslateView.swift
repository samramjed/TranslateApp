import SwiftUI

struct TranslateView: View {
    // UI state only (no real ML yet)
    @State private var sourceLanguage = "English (US)"
    @State private var targetLanguage = "Spanish (Spain)"
    @State private var sourceText = ""
    @State private var targetText = ""
    @State private var showFavourites = false
    @State private var showOptions = false
    @State private var showGrammaticalGender = true
    @State private var showOptionsMenu = false



    var body: some View {
        ZStack {
            // Background like Apple Translate
            Color(.systemGroupedBackground)
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 16) {

                // MARK: - Top bar
                HStack {
                    Button {
                            showFavourites = true
                        } label: {
                            ZStack {
                                Circle()
                                    .fill(Color(.systemBackground))
                                    .frame(width: 36, height: 36)
                                    .shadow(color: Color.black.opacity(0.06),
                                            radius: 2, x: 0, y: 1)

                                Image(systemName: "list.star")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.black)
                            }
                        }
                        .buttonStyle(.plain)

                        Spacer()

                        // Right ellipsis button (optional: same circular style)
                    // Right ellipsis button
                    Button {
                        withAnimation(.spring(response: 0.25, dampingFraction: 0.9)) {
                            showOptionsMenu.toggle()
                        }
                    } label: {
                        ZStack {
                            Circle()
                                .fill(Color(.systemBackground))
                                .frame(width: 36, height: 36)
                                .shadow(color: Color.black.opacity(0.06),
                                        radius: 2, x: 0, y: 1)

                            Image(systemName: "ellipsis")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.black)
                        }
                    }
                    .buttonStyle(.plain)

                }

                Text("Translate")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundColor(.primary)

                // MARK: - Main card
                ZStack {
                    RoundedRectangle(cornerRadius: 32, style: .continuous)
                        .fill(Color(.systemBackground))

                    GeometryReader { geo in
                        ZStack {
                            // ===== CARD CONTENT (top + bottom) =====
                            VStack(alignment: .leading, spacing: 18) {

                                // --- Top language row ---
                                HStack {
                                    Button {
                                        // later: show language picker
                                    } label: {
                                        HStack(spacing: 4) {
                                            Text(sourceLanguage)
                                                .font(.headline)
                                                .foregroundColor(.primary)
                                            Image(systemName: "chevron.down")
                                                .font(.caption2)
                                                .foregroundColor(.secondary)
                                        }
                                    }

                                    Spacer()
                                }

                                // --- Source text + mic ---
                                HStack(alignment: .top, spacing: 8) {
                                    ZStack(alignment: .topLeading) {
                                        if sourceText.isEmpty {
                                            Text("Enter text")
                                                .foregroundColor(Color(.systemGray4))
                                                .font(.system(size: 30, weight: .regular))
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
                                        // later: start/stop mic for source
                                    } label: {
                                        Image(systemName: "microphone")
                                            .font(.title2)
                                            .foregroundColor(Color(.black))
                                    }
                                    .padding(.top, 6)
                                }

                                // This spacer creates breathing room above the center line
                                Spacer(minLength: 40)

                                // --- Bottom language row ---
                                HStack {
                                    Button {
                                        // later: target language picker
                                    } label: {
                                        HStack(spacing: 4) {
                                            Text(targetLanguage)
                                                .font(.headline)
                                                .foregroundColor(Color(.systemTeal))
                                            Image(systemName: "chevron.down")
                                                .font(.caption2)
                                                .foregroundColor(Color(.systemTeal))
                                        }
                                    }

                                    Spacer()
                                }

                                // --- Target text + mic ---
                                HStack(alignment: .top, spacing: 8) {
                                    Text(
                                        targetText.isEmpty
                                        ? "Introducir texto"
                                        : targetText
                                    )
                                    .font(.system(size: 28, weight: .semibold))
                                    .foregroundColor(
                                        targetText.isEmpty
                                        ? Color(.systemTeal).opacity(0.25)
                                        : .primary
                                    )
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.bottom, 4)

                                    Button {
                                        // later: mic / playback for target
                                    } label: {
                                        Image(systemName: "microphone")
                                            .font(.title2)
                                            .foregroundColor(Color(.systemTeal))
                                    }
                                    .padding(.top, 6)
                                }
                            }
                            .padding(20)

                            // ===== CENTER DIVIDER =====
                            Rectangle()
                                .fill(Color(.separator))
                                .frame(
                                    width: geo.size.width - 40, // inset same as content padding
                                    height: 0.5
                                )
                                .position(
                                    x: geo.size.width / 2,
                                    y: geo.size.height / 2
                                )

                            // ===== CENTER SWAP BUTTON =====
                            Button {
                                swap(&sourceLanguage, &targetLanguage)
                                swap(&sourceText, &targetText)
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
                            .position(
                                x: geo.size.width / 2,
                                y: geo.size.height / 2
                            )
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
        
        .overlay(alignment: .topTrailing) {
            if showOptionsMenu {
                ZStack(alignment: .topTrailing) {

                    // Tap anywhere to dismiss
                    Color.clear
                        .ignoresSafeArea()
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation(.spring(response: 0.25, dampingFraction: 0.9)) {
                                showOptionsMenu = false
                            }
                        }

                    // The actual menu card
                    TranslateOptionsMenu(showGrammaticalGender: $showGrammaticalGender)
                        .padding(.trailing, 24)   // distance from right edge
                        .padding(.top, 76)        // distance from top (adjust to line up under your ellipsis)
                        .transition(.move(edge: .top).combined(with: .opacity))
                }
                .zIndex(1) // keep it on top of everything
            }
        
        }
        .sheet(isPresented: $showFavourites) {
            FavouritesView()
        
    }
    

}

struct TranslateOptionsMenu: View {
    @Binding var showGrammaticalGender: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {

            // Row: Languages
            Button {
                // TODO: open languages screen later
            } label: {
                HStack(spacing: 12) {
                    Image(systemName: "gear")
                        .font(.system(size: 20, weight: .regular))
                    Text("Languages")
                        .font(.system(size: 18, weight: .regular))
                    Spacer()
                }
                .foregroundColor(.primary)
            }

            Divider()

            // Row: Show Grammatical Gender
            Button {
                showGrammaticalGender.toggle()
            } label: {
                HStack(spacing: 12) {
                    Image(systemName: showGrammaticalGender ? "checkmark" : "circle")
                        .font(.system(size: 18, weight: .semibold))

                    Image(systemName: "person.bubble")
                        .font(.system(size: 18, weight: .regular))

                    Text("Show Grammatical\nGender")
                        .font(.system(size: 16, weight: .regular))
                        .lineLimit(2)
                    Spacer()
                }
                .foregroundColor(.primary)
            }
        }
        .padding(20)
        .frame(maxWidth: 320)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
    }
}
}


#Preview {
    RootView()
}
