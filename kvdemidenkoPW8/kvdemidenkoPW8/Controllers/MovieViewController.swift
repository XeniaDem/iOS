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
    
    var movies: [Movie]  = []
    
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
        //tableView.backgroundColor = .white
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
        guard let url = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=\(apiKey)&language=ruRu") else {
            return assertionFailure("some problems with url")
        }
        let urlSession = URLSession.shared.dataTask(with: URLRequest(url: url), completionHandler: {data, _, _ in
            guard
                let data = data,
                let dict = try? JSONSerialization.jsonObject(with: data, options: .json5Allowed) as? [String: Any],
                let results = dict["results"] as? [[String: Any]]
            else {
                return
            }
            let movies: [Movie] = results.map { params in
                let title = params["title"] as! String
                let imagePath = params["poster_path"] as? String
                return Movie(
                    title: title,
                    posterPath: imagePath!,
                    poster: nil
                )
            }
            self.movies = movies
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        urlSession.resume()
    }
}

extension MovieViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(movies.count)
        return movies.count
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieViewCell.identifier, for: indexPath) as! MovieViewCell
        cell.configure(movie: movies[indexPath.row])
        return cell
    }
    
}
 
