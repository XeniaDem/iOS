//
//  ViewController.swift
//  kvdemidenkoPW8
//
//  Created by Ксения Демиденко on 22.03.2022.
//

import UIKit

class MovieViewController: UIViewController {
    private let tableView = UITableView()
    private let poster = UIImageView()
    private let titleLabel = UILabel()
    
    private let apiKey = "188ba2382905beea02bfbffd4da86ade"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.loadMovies()
         }
    }
    
    private func configureUI() {
        view.addSubview(tableView)
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.register(MovieViewCell.self, forCellReuseIdentifier: MovieViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        tableView.reloadData()
    }
    private func loadMovies() {
        guard let url = URL(string: "https://api.themoviedb.org/3/discover/movie?/api_key=\(apiKey)&language=ruRu") else {
            return assertionFailure("some problems with url")
        }
        let urlSession = URLSession.shared.dataTask(with: URLRequest(url: url), completionHandler: {data, _, _ in
            
        })
        urlSession.resume()
    }
}

extension MovieViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return MovieViewCell()
    }
    
}
 
