//
//  ThumbnailImage.swift
//  NYTimesApp
//
//  Created by Murtaza on 20/08/2025.
//


import SwiftUI

struct ThumbnailImage: View {
    let url: URL?
    var size: CGFloat = 40
    var placeholderColor: Color = .gray.opacity(0.3)

    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                Circle()
                    .fill(placeholderColor)
                    .frame(width: size, height: size)

            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: size, height: size)
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(Color.white.opacity(0.8), lineWidth: 1)
                    )

            case .failure:
                Circle()
                    .fill(placeholderColor)
                    .frame(width: size, height: size)

            @unknown default:
                EmptyView()
            }
        }
    }
}
