//
//  ArticleRowView.swift
//  NYTimesApp
//
//  Created by Murtaza on 19/08/2025.
//

import SwiftUI

struct ArticleRowView: View {
    
    var article: ArticleResult
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack(spacing: 5) {
                ThumbnailImage(url: URL(string: article.media?.first?.mediaMetadata?.filter({$0.format == .standardThumbnail}).first?.url ?? ""))
                VStack(alignment: .leading, spacing: 5) {
                    Text(article.title ?? "")
                        .font(.system(size: 16, weight: .bold))
                        .lineLimit(2)
                    Text(article.byline ?? "")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundStyle(Color.gray)
                    Text("Published Date: \(article.publishedDate ?? "")")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(Color.gray)
                }
            }
            Rectangle()
                .fill(Color.gray)
                .frame(height: 1)
                .padding(.vertical, 10)
        }
    }
}
