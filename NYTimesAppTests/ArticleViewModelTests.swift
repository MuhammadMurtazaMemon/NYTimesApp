//
//  ArticleViewModelTests.swift
//  NYTimesApp
//
//  Created by Murtaza on 21/08/2025.
//

import Foundation
import XCTest
@testable import NYTimesApp

final class ArticleViewModelTests: XCTestCase {
    
    func testArticlesViewModelSuccess() {
        let viewModel = ArticlesViewModel()
        viewModel.getArticles { error in
            XCTAssertNil(error)
            XCTAssertEqual(viewModel.articles.isEmpty, false)
        }
    }
    
    func testArticlesViewModelFailure() {
        //Failure - Case: API will give error, because accepted periods are 1 7 and 30
        let viewModel = ArticlesViewModel()
        viewModel.getArticles(period: "4") { error in
            XCTAssertNotNil(error)
            XCTAssertEqual(viewModel.articles.count, 0)
        }
    }
    
}
