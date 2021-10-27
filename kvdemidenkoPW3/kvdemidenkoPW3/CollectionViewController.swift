//
//  CollectionViewController.swift
//  kvdemidenkoPW3
//
//  Created by Ксения Демиденко on 24.10.2021.
//

import Foundation
import UIKit
class CollectionViewController: UIViewController {
    private var collection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemOrange
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        let layoutFlow = UICollectionViewFlowLayout()
        layoutFlow.scrollDirection = .horizontal
        layoutFlow.itemSize = CGSize(width: 150, height: 60)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layoutFlow)
        view.addSubview(collection)
        collection.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        collection.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor)
        collection.pin(to: view, .left, .right)
        collection.backgroundColor = .white
        self.collection = collection
        collection.dataSource = self
        collection.delegate = self
        collection.register(AlarmCollection.self, forCellWithReuseIdentifier: "alarmCollection")
        collection.showsVerticalScrollIndicator = true
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.layer.masksToBounds = true
        self.view.addSubview(collection)
    }
}
    
extension CollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection
                    section: Int) -> Int { 300 }
    func numberOfSections(in tableView: UITableView) -> Int { 1 }
}

extension CollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "alarmCollection",
            for: indexPath
        ) as! AlarmCollection
        cell.layer.masksToBounds = true
        return cell
    }
}

class AlarmCollection: UICollectionViewCell
{
    var alarm: AlarmModel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.alarm = AlarmModel(hours: Int.random(in: 0...23), minutes: Int.random(in: 0...59), isActive: false)
        addSubview(alarm)
        alarm.autoresizingMask = self.autoresizingMask
        alarm.timeLabel.pinRight(to: self)
        alarm.toggle.translatesAutoresizingMaskIntoConstraints = false;
        //alarm.timeLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true;
        alarm.toggle.pinRight(to: self, 10)
        alarm.timeLabel.font = UIFont.systemFont(ofSize: 30)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


