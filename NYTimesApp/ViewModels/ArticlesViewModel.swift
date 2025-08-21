//
//  ArticlesViewModel.swift
//  NYTimesApp
//
//  Created by Murtaza on 18/08/2025.
//

import Foundation

class ArticlesViewModel: NSObject, ObservableObject {
    
    public let model: ArticlesModel
    
    @Published public var articles: [ArticleResult] = []
    
    init(model: ArticlesModel) {
        self.model = model
    }
    
    public convenience override init() {
        self.init(model: ArticlesModel())
    }
    
    public func getArticles(period: String = "7", _ result: @escaping(NetworkError?) -> Void) {
        model.getArticles(period: period) { [weak self] response  in
            switch response {
            case .success(let articles):
                self?.articles = articles
            case .failure(let error):
                result(error)
            }
        }
    }
}
