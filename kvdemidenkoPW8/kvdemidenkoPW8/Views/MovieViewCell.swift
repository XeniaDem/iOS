//
//  MovieViewCell.swift
//  kvdemidenkoPW8
//
//  Created by Ксения Демиденко on 22.03.2022.
//

import UIKit

class MovieViewCell: UITableViewCell {
    static let identifier = "MovieViewCell"
    private let poster = UIImageView()
    private let title = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: Self.identifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    private func configureUI() {
        poster.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        //addSubview(poster)
        addSubview(title)
        
        NSLayoutConstraint.activate([
//            poster.topAnchor.constraint(equalTo: topAnchor),
//            poster.leadingAnchor.constraint(equalTo: leadingAnchor),
//            poster.trailingAnchor.constraint(equalTo: trailingAnchor),
//            poster.heightAnchor.constraint(equalToConstant: 200),
            
            //title.topAnchor.constraint(equalTo: poster.bottomAnchor, constant: 10),
            title.topAnchor.constraint(equalTo: topAnchor, constant: 10),

            title.leadingAnchor.constraint(equalTo: leadingAnchor),
            title.trailingAnchor.constraint(equalTo: trailingAnchor),
            title.heightAnchor.constraint(equalToConstant: 20)
        ])
        title.textAlignment = .center
    }
    func configure(movie: Movie) {
        title.text = movie.title
        poster.image = movie.poster
    }
}
