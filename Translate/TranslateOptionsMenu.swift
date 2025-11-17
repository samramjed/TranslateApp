//
//  TranslateOptionsMenu.swift
//  Translate
//
//  Created by Samra Amjed on 17/11/25.
//

import Foundation
import SwiftUI

struct TranslateOptionsMenu: View {
    @Binding var showGender: Bool

    var body: some View {
        VStack(spacing: 0) {

            // Row 1: Languages
            HStack(spacing: 12) {
                Image(systemName: "gear")
                    .font(.system(size: 18, weight: .regular))
                    .foregroundColor(.black)

                Text("Languages")
                    .font(.system(size: 18, weight: .regular))
                    .foregroundColor(.black)

                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 14)

            // Divider
            Divider()
                .padding(.horizontal, 20)

            // Row 2: Show grammatical gender
            HStack(spacing: 12) {
                // Checkmark (on/off)
                Image(systemName: showGender ? "checkmark" : "checkmark")
                    .opacity(showGender ? 1 : 0)   // hide when off, still keeps spacing
                    .font(.system(size: 16, weight: .semibold))

                Image(systemName: "person.bubble")
                    .font(.system(size: 18, weight: .regular))

                Text("Show Grammatical\nGender")
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.black)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)

                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.15)) {
                    showGender.toggle()
                }
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 32, style: .continuous)
                .fill(.ultraThinMaterial) // nice frosted card like Apple's
        )
        .shadow(color: Color.black.opacity(0.12), radius: 12, x: 0, y: 4)
        .shadow(color: Color.black.opacity(0.04), radius: 1, x: 0, y: 0.5)
    }
    
}

#Preview {
    RootView()
}
