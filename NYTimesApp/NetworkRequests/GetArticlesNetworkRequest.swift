//
//  GetArticlesNetworkRequest.swift
//  NYTimesApp
//
//  Created by Murtaza on 19/08/2025.
//

import Foundation

class GetArticlesNetworkRequest: NetworkRequestable {
    let method: NetworkMethod = .GET
    let url: URL
    let parameters: [String : PropertyListValue] = [:]
    init(period: String) {
        url = URL(string: "https://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/\(period).json?api-key=\(apiKey)")!
    }
}
