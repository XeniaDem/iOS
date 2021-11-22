//
//  ArticleManager.swift
//  kvdemidenkoPW5
//
//  Created by Ксения Демиденко on 20.11.2021.
//

import UIKit
class ArticleManager {
    private func getURL(_ rubric: Int, _ pageIndex: Int) -> URL? {
        URL(string: "https://news.myseldon.com/api/Section?rubricId=\(rubric)&pageSize=8&pageIndex=\(pageIndex)")
    }

    var articles: [ArticleModel]? {
        didSet {
            
            self.update?.didUpdated(finished: true)
                
            }
        }

    var update: UpdateProtocol?
    var articlePage: ArticlePage?

    // MARK: - Fetch news
    private func fetchNews() {
        guard let url = getURL(4, 1) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print(error)
                return
            }
            if let data = data {
                self?.articlePage = try?JSONDecoder().decode(ArticlePage.self, from: data)
                self?.articlePage?.passTheRequestId()
                self?.articles = self?.articlePage?.news
            }
        }.resume()
    }
    public func setupArticles(){
        fetchNews()
    }
}


