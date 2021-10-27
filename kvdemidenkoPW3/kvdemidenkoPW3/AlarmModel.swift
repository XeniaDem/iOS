//
//  AlarmModel.swift
//  kvdemidenkoPW3
//
//  Created by Ксения Демиденко on 23.10.2021.
//

import UIKit
class AlarmModel: UIView {
    var timeLabel =  UILabel();
    let toggle = UISwitch();
    var hours : Int
    var minutes : Int
    public var isActive : Bool
    init(hours: Int, minutes: Int, isActive: Bool) {
        self.hours = hours;
        self.minutes = minutes;
        self.isActive = isActive;
        if (minutes < 10) {
            timeLabel.text = hours.description + ":0" + minutes.description;
        } else {
            timeLabel.text = hours.description + ":" + minutes.description;
        }
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        addSubview(toggle);
        addSubview(timeLabel);
        timeLabel.textColor = UIColor.black;
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.font = UIFont.systemFont(ofSize: 35)
        timeLabel.pinLeft(to: self, 10)
        timeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        toggle.translatesAutoresizingMaskIntoConstraints = false
        toggle.pinTop(to: topAnchor, 15)
        toggle.pinRight(to: self, 15)
        toggle.isOn = isActive;
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func locationToggleSwitched(_ sender: UISwitch) {
        if sender.isOn {
            if(isActive == false)
            {
                isActive = true
            } else {
                isActive = false;
            }
        } else {
            if(isActive == true)
            {
                isActive = false;
            } else {
                isActive = true;
            }
           
        }
    }
}
