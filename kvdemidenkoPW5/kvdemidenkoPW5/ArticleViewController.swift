//
//  ArticleViewController.swift
//  kvdemidenkoPW5
//
//  Created by Ксения Демиденко on 19.11.2021.
//

import UIKit

class ArticleViewController: UIViewController, UpdateProtocol {
    func didUpdated(finished: Bool) {
        guard finished else {
                return
            }
            news = articleManager.articles ?? []
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = articleManager.articles?[indexPath.row]
        let webViewController = WebViewController()
        webViewController.url = article?.articleUrl
        navigationController?.pushViewController(webViewController, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
          return cellSpacingHeight
    }
      

    var tableView: UITableView!
    var cellSpacingHeight: CGFloat = 10
    var articleManager = ArticleManager()
    var news: [ArticleModel]  = [] {
        didSet{
            DispatchQueue.main.async{ [self] in
                tableView.reloadData()
                tableView.isHidden = news.isEmpty
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        articleManager.update = self
        articleManager.setupArticles()
        view.backgroundColor = UIColor.white
        setupArticleView()
    }
    
    private func setupArticleView() {
        let rect = CGRect(x: 15, y: 15, width: view.frame.width - 20, height: view.frame.height - 20)
        tableView = UITableView(frame: rect)
        tableView.register(ArticleCell.self, forCellReuseIdentifier: "ArticleCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.clear
        tableView.rowHeight = 100
        tableView.showsVerticalScrollIndicator = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.layer.cornerRadius = 20
        tableView.layer.masksToBounds = true
        self.view.addSubview(tableView)
    }
}


struct ArticlePage: Decodable {
    var news: [ArticleModel]?
    var requestId: String?
    mutating func passTheRequestId() {
        for i in 0..<(news?.count ?? 0) {
            news?[i].requestId = requestId
        }
    }
}

struct ArticleModel: Decodable {
    var newsId: Int?
    var title: String?
    var announce: String?
    var img: ImageContainer?
    var requestId: String?
    var articleUrl: URL? {
        let requestId = requestId ?? ""
        let newsId = newsId ?? 0
        return URL(string: "https://news.myseldon.com/ru/news/index/\(newsId)?requestId=\(requestId)")
    }
}

struct ImageContainer: Decodable {
    var url: URL?
}

extension ArticleViewController: UITableViewDelegate {
    private func handleMarkAsFavourite() {
        print("Marked as favourite")
    }

    private func handleMarkAsUnread() {
        print("Marked as unread")
    }

    private func handleMoveToTrash() {
        print("Moved to trash")
    }

    private func handleMoveToArchive() {
        print("Moved to archive")
    }
    
    func tableView(_ tableView: UITableView,
                   leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal,
                                        title: "Favourite") { [weak self] (action, view, completionHandler) in
                                            self?.handleMarkAsFavourite()
                                            completionHandler(true)
        }
        action.backgroundColor = .systemBlue
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func tableView(_ tableView: UITableView,
                       trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // Archive action
        let archive = UIContextualAction(style: .normal,
                                         title: "Archive") { [weak self] (action, view, completionHandler) in
                                            self?.handleMoveToArchive()
                                            completionHandler(true)
        }
        archive.backgroundColor = .systemGreen

        // Trash action
        let trash = UIContextualAction(style: .destructive,
                                       title: "Trash") { [weak self] (action, view, completionHandler) in
                                        self?.handleMoveToTrash()
                                        completionHandler(true)
        }
        trash.backgroundColor = .systemRed

        // Unread action
        let unread = UIContextualAction(style: .normal,
                                       title: "Mark as Unread") { [weak self] (action, view, completionHandler) in
                                        self?.handleMarkAsUnread()
                                        completionHandler(true)
        }
        unread.backgroundColor = .systemOrange
        let configuration = UISwipeActionsConfiguration(actions: [trash, archive, unread])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
        
    }
}

extension ArticleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleManager.articles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleCell
        cell.articleModel = articleManager.articles?[indexPath.row] ?? ArticleModel()
        cell.setupCell()
        cell.layer.masksToBounds = true
        return cell
    }
}


