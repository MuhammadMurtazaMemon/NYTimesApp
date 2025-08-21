//
//  CoverImage.swift
//  NYTimesApp
//
//  Created by Murtaza on 20/08/2025.
//

import SwiftUI

struct CoverImage: View {
    let url: URL?
    var size: CGFloat = 250
    var placeholderColor: Color = .gray.opacity(0.3)

    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                Rectangle()
                    .fill(placeholderColor)
                    .frame(width: UIScreen.main.bounds.width, height: size)

            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: size)
                    .clipShape(Rectangle())
                    .overlay(
                        Rectangle().stroke(Color.white.opacity(0.8), lineWidth: 1)
                    )

            case .failure:
                Rectangle()
                    .fill(placeholderColor)
                    .frame(width: UIScreen.main.bounds.width, height: size)

            @unknown default:
                EmptyView()
            }
        }
    }
}
