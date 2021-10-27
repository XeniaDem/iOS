//
//  StackViewController.swift
//  kvdemidenkoPW3
//
//  Created by Ксения Демиденко on 23.10.2021.
//

import Foundation
import UIKit
class StackViewController: UIViewController {
    private var stack: UIStackView!
    private var scroll: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemPurple
        setupScroll()
        setupStackView()
        var cell: AlarmStack = AlarmStack()
        var indent: Double = 10
        for _ in 0...200 {
            cell = AlarmStack()
            cell.setHeight(to: 50)
            cell.layer.masksToBounds = true
            cell.translatesAutoresizingMaskIntoConstraints = false
            stack.addArrangedSubview(cell)
            cell.pinTop(to: stack.topAnchor, indent)
            indent += 60
        }
    }
        
    private func setupScroll() {
        scroll = UIScrollView(frame: CGRect.init())
        view.addSubview(scroll)
        scroll.pinTop(to: view.topAnchor)
        scroll.pinBottom(to: view.bottomAnchor)
        scroll.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scroll.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scroll.contentSize = CGSize(
            width:
                self.scroll.frame.width,
            height: stack.frame.height)
        scroll.alwaysBounceVertical = true
    }
    
    private func setupStackView() {
        let stack = UIStackView(frame: CGRect.init())
        scroll.addSubview(stack)
        stack.distribution = .fillEqually
        stack.axis = .vertical
        stack.pinTop(to: scroll.topAnchor)
        stack.leftAnchor.constraint(equalTo: scroll.leftAnchor).isActive = true
        stack.rightAnchor.constraint(equalTo: scroll.rightAnchor).isActive = true
        stack.pinBottom(to: scroll.bottomAnchor)
        stack.widthAnchor.constraint(equalTo: scroll.widthAnchor).isActive = true
        stack.backgroundColor = .white
        self.stack = stack
    }
}

class AlarmStack: UIView
{
    var alarm: AlarmModel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.alarm = AlarmModel(hours: Int.random(in: 0...23), minutes: Int.random(in: 0...59), isActive: false)
        addSubview(alarm)
        alarm.autoresizingMask = self.autoresizingMask
        alarm.toggle.pinRight(to: self, 15)
        alarm.toggle.pinTop(to: self, 15)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
