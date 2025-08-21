//
//  ArticlesModel.swift
//  NYTimesApp
//
//  Created by Murtaza on 19/08/2025.
//

import Foundation

class ArticlesModel: NSObject {
    
    private let network: NetworkService
    
    init(network: NetworkService = URLNetworkService(session: URLSession(configuration: .ephemeral))) {
        self.network = network
    }
    
    func getArticles(period: String,_ result: @escaping((Result<[ArticleResult], NetworkError>) -> ())) {
        let request = GetArticlesNetworkRequest(period: period)
        network.performOperation(on: request) { (response: Result<Articles, NetworkError>) in
            switch response {
            case .success(let responseData):
                result(.success(responseData.results ?? []))
            case .failure(let error):
                result(.failure(error))
            }
        }
    }
}
