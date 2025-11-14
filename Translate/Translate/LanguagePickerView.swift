import SwiftUI

struct LanguagePickerView: View {
    @Environment(\.dismiss) private var dismiss

    let title: String
    @Binding var selectedLanguage: AppLanguage

    var body: some View {
        NavigationStack {
            List {
                ForEach(AppLanguage.allCases) { language in
                    Button {
                        selectedLanguage = language
                        dismiss()          // close the sheet after selection
                    } label: {
                        HStack {
                            Text(language.displayName)
                                .foregroundColor(.primary)

                            Spacer()

                            if language == selectedLanguage {
                                Image(systemName: "checkmark")
                                    .foregroundStyle(.tint)
                            }
                        }
                    }
                }
            }
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
        .presentationDetents([.medium, .large])
        .presentationDragIndicator(.visible)
    }
}
