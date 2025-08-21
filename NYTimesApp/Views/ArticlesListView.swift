//
//  ArticlesListView.swift
//  NYTimesApp
//
//  Created by Murtaza on 18/08/2025.
//

import SwiftUI

struct ArticlesListView: View {
    
    @StateObject private var viewModel = ArticlesViewModel()
    @StateObject private var errorHandler = NetworkErrorHandler()
    @State private var showDetail: Bool = false
    @State private var selectedArticle: ArticleResult?
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Popular Articles")
                    .font(.title)
                    .foregroundStyle(Color.primary)
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(viewModel.articles.indices, id: \.self) { index in
                            ArticleRowView(article: viewModel.articles[index])
                                .onTapGesture {
                                    selectedArticle = viewModel.articles[index]
                                    showDetail = true
                                }
                        }
                    }
                }
            }
            .padding(.horizontal)
            .onAppear {
                viewModel.getArticles { networkError in
                    if let error = networkError {
                        errorHandler.showErrorMessage(error)
                    }
                }
            }
            .navigationDestination(isPresented: $showDetail, destination: {
                ArticleDetailView(selectedArticle: selectedArticle)
            })
            .loader(viewModel.articles.count == 0)
            .withErrorHandling(errorHandling: errorHandler)
        }
    }
}

#Preview {
    ArticlesListView()
}
