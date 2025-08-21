//
//  ArticleDetailView.swift
//  NYTimesApp
//
//  Created by Murtaza on 20/08/2025.
//

import SwiftUI

struct ArticleDetailView: View {
    
    var selectedArticle: ArticleResult?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                CoverImage(url: URL(string: selectedArticle?.media?.first?.mediaMetadata?.filter({$0.format == .mediumThreeByTwo440}).first?.url ?? ""))
                VStack(alignment: .leading, spacing: 10) {
                    Text(selectedArticle?.title ?? "")
                        .font(.system(size: 16, weight: .bold))
                        .lineLimit(2)
                    Text(selectedArticle?.abstract ?? "")
                        .font(.system(size: 15, weight: .regular))
                    Text(selectedArticle?.byline ?? "")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundStyle(Color.gray)
                    Text("Published Date: \(selectedArticle?.publishedDate ?? "")")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(Color.gray)
                    if let url = URL(string: selectedArticle?.url ?? "") {
                        Link(destination: url) {
                            Label("Read Full Article", systemImage: "link")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(.blue)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    ArticleDetailView()
}
