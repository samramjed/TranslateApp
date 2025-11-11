import SwiftUI

struct FavouritesView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            // Same soft background as main app
            Color(.systemGroupedBackground)
                .ignoresSafeArea()

            VStack {
                // Top row: title centered visually, close button on the right
                HStack {
                    Spacer()

                    Text("Favourites")
                        .font(.title2.weight(.semibold))
                        .foregroundColor(.primary)

                    Spacer()

                    Button {
                        dismiss()
                    } label: {
                        ZStack {
                            Circle()
                                .fill(Color(.systemBackground))
                                .frame(width: 40, height: 40)
                                .shadow(color: Color.black.opacity(0.06),
                                        radius: 2, x: 0, y: 1)
                            Image(systemName: "xmark")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.black)
                        }
                    }
                    .buttonStyle(.plain)
                }
                .padding(.horizontal, 20)
                .padding(.top, 24)

                Spacer()

                // Center content
                VStack(spacing: 16) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 64))
                        .foregroundColor(Color(.systemGray3))

                    Text("No Favourites")
                        .font(.title2.weight(.semibold))
                        .foregroundColor(.primary)

                    Text("Your favourite translations will appear here.")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                }

                Spacer()
            }
        }
    }
}

#Preview {
    FavouritesView()
}
