//
//  ViewController.swift
//  kvdemidenkoPW1
//
//  Created by Ксения Демиденко on 15.09.20//
//

import UIKit
class ViewController: UIViewController {
    
    @IBOutlet var views: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var set = Set<UIColor>()
        while set.count < views.count {
            set.insert(
                UIColor(
                    red: .random(in: 0...1),
                    green: .random(in: 0...1),
                    blue: .random(in: 0...1),
                    alpha: 1
                )
            )
        }
        
        for view in self.views {
            view.layer.cornerRadius = CGFloat.random(in: 10..<100)
            view.backgroundColor = set.popFirst()
        }
    }

    @IBAction func changeColorButtonPressed(_ sender: Any)
    {
        let button = sender as? UIButton
        button?.isEnabled = false
        var set = Set<UIColor>()
        while set.count < views.count {
            set.insert(
                UIColor(
                    red: .random(in: 0...1),
                    green: .random(in: 0...1),
                    blue: .random(in: 0...1),
                    alpha: 1
                )
            )
        }
        UIView.animate(withDuration: 0.8,
            animations: {
                self.view.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            },
            completion: { _ in
                UIView.animate(withDuration: 0.8) {
                    self.view.transform = CGAffineTransform.identity
                }
            })
        
        UIView.animate(withDuration: 2, animations: {
            for view in self.views {
                view.layer.cornerRadius = CGFloat.random(in: 10..<100)
                view.backgroundColor = set.popFirst()
            }
        }) { completion in
            button?.isEnabled = true
        }
    }
    
    
}

