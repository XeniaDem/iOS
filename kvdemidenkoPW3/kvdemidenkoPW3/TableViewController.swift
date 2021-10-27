//
//  TableViewController.swift
//  kvdemidenkoPW3
//
//  Created by Ксения Демиденко on 23.10.2021.
//

import Foundation
import UIKit
class TableViewController: UIViewController {
    private var alarms: [AlarmModel] = []
    private var table: UITableView?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemGreen
        setupTableView()
    }
    
    private func setupTableView() {
        let tableView = UITableView(frame: .zero)
        view.addSubview(tableView)
        tableView.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        tableView.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor)
        tableView.pinLeft(to: view)
        tableView.pinRight(to: view)
        self.table = tableView
        tableView.register(AlarmCell.self, forCellReuseIdentifier: "alarmCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.setHeight(to: 60)
        tableView.rowHeight = 60
        tableView.backgroundColor = .systemGreen
    }
}

//final class EyeCell: UITableViewCell {
//    func setupEye() {
//    setHeight(to: 50)
//    let image = UIImageView()
//    addSubview(image)
//    image.pinLeft(to: self, Double.random(in: 0...400))
//
//    image.pinTop(to: self, Double.random(in: -20...40))
//    image.image = UIImage(named: "eye")
//    image.setHeight(to: 20)
//    image.setWidth(to: 30)
//    }
//    override func prepareForReuse() {
//        for subview in subviews {
//            if subview is UIImageView {
//                subview.removeFromSuperview()
//            }
//        }
//    }
//}

extension TableViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection
                    section: Int) -> Int { 300 }
    func numberOfSections(in tableView: UITableView) -> Int { 1 }
}

extension TableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "alarmCell",
            for: indexPath
        ) as? AlarmCell
        return cell ?? UITableViewCell()
    }
}

final class AlarmCell: UITableViewCell {
    var alarm: AlarmModel!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.alarm = AlarmModel(hours: Int.random(in: 0...23), minutes: Int.random(in: 0...59), isActive: false)
        addSubview(alarm)
        alarm.autoresizingMask = self.autoresizingMask
        self.accessoryView = alarm.toggle
        self.accessoryView?.pinTop(to: self, 15)
        self.accessoryView?.pinRight(to: self, 20)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        for subview in subviews {
            if subview is AlarmModel {
               //subview.removeFromSuperview()
            }
        }
    }
}
