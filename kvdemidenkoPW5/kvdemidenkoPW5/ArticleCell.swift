//
//  ArticleCell.swift
//  kvdemidenkoPW5
//
//  Created by Ксения Демиденко on 20.11.2021.
//

import UIKit
class ArticleCell: UITableViewCell {
    
public var articleModel = ArticleModel()

    let image: UIImageView = {
        let image = UIImageView()
        return image
    }()

    let titleLabel: UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        title.textAlignment = .center
        title.textColor = UIColor.white
        title.lineBreakMode = .byClipping
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()

    let descriptionLabel: UILabel = {
        let description = UILabel()
        description.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        description.textAlignment = .left
        description.textColor = UIColor.white
        description.lineBreakMode = .byClipping
        description.translatesAutoresizingMaskIntoConstraints = false
        return description
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

    required init?(coder aDecoder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }

    private func loadImage() -> UIImage? {
        guard let data = try? Data(contentsOf: (articleModel.img?.url)!) else {
            return nil
        }
        return UIImage(data: data)
    }
    
    func setupCell(){
        backgroundColor = UIColor.clear
        DispatchQueue.main.async {
            self.image.image = self.loadImage()
        }
        titleLabel.text = articleModel.title
        descriptionLabel.text = articleModel.announce
        backgroundView = image
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: bottomAnchor, constant: -30).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
    }
}
