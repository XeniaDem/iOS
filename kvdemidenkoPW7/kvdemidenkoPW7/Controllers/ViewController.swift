//
//  ViewController.swift
//  kvdemidenkoPW7
//
//  Created by Ксения Демиденко on 28.01.2022.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.frame = CGRect(x: 10, y: 30, width: view.frame.size.width, height: view.frame.size.height)
        mapView.mapType = MKMapType.standard
        mapView.center = view.center
        view.addSubview(mapView)
        clearButton.isEnabled = false;
        goButton.isEnabled = false;
        buttonsStackView.addArrangedSubview(goButton)
        buttonsStackView.addArrangedSubview(clearButton)
        view.addSubview(buttonsStackView)
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        buttonsStackView.centerYAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -50).isActive = true
        
        textStack.axis = .vertical
        view.addSubview(textStack)
        textStack.spacing = 10
        textStack.pin(to: view, [.top: 50, .left: 10, .right: 10])
        [startLocation, endLocation].forEach {
            textField in
            textField.setHeight(to: 40)
            textField.delegate = self
            textStack.addArrangedSubview(textField)
        }
        let press = UITapGestureRecognizer(target: self, action: #selector(keyboardPressedOutside))
        view.addGestureRecognizer(press)

    }
    private let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.layer.masksToBounds = true
        mapView.layer.cornerRadius = 5
        mapView.clipsToBounds = false
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.showsScale = true
        mapView.showsCompass = true
        mapView.showsTraffic = true
        mapView.showsBuildings = true
        mapView.showsUserLocation = true
        return mapView
    }()
    
    
    private let goButton: CustomButton = {
        let button = CustomButton(with: CustomButtonViewModel(title: "Go", backgroundColor: .systemBlue, textColor: .white))
        button.widthAnchor.constraint(equalToConstant: 130.0).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        button.layer.cornerRadius = 20
        button.setTitleColor(.gray, for: .disabled)
        button.isEnabled = false
        button.addTarget(self, action: #selector(goButtonWasPressed), for: .touchUpInside)
        return button
    }()
    
    private let clearButton: CustomButton = {
        let button = CustomButton(with: CustomButtonViewModel(title: "Clear", backgroundColor: UIColor.darkGray, textColor: UIColor.white))
        button.widthAnchor.constraint(equalToConstant: 130.0).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        button.layer.cornerRadius = 20
        button.setTitleColor(.gray, for: .disabled)
        button.isEnabled = false
        button.addTarget(self, action: #selector(clearButtonWasPressed), for: .touchUpInside)
        return button
    }()
    
    private let buttonsStackView: UIStackView = {
        let view = UIStackView()
        return view
    }()
    
    let startLocation: UITextField = {
        let control = UITextField()
        control.backgroundColor = UIColor.white
        control.textColor = UIColor.darkGray
        control.placeholder = "From"
        control.layer.cornerRadius = 2
        control.clipsToBounds = false
        control.font = UIFont.systemFont(ofSize: 15)
        control.borderStyle = UITextField.BorderStyle.roundedRect
        control.autocorrectionType = UITextAutocorrectionType.yes
        control.keyboardType = UIKeyboardType.default
        control.returnKeyType = UIReturnKeyType.done
        control.clearButtonMode = UITextField.ViewMode.whileEditing
        control.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return control
    }()
    
   let endLocation: UITextField = {
        let control = UITextField()
        control.backgroundColor = UIColor.white
        control.textColor = UIColor.darkGray
        control.placeholder = "To"
        control.layer.cornerRadius = 2
        control.clipsToBounds = false
        control.font = UIFont.systemFont(ofSize: 15)
        control.borderStyle = UITextField.BorderStyle.roundedRect
        control.autocorrectionType = UITextAutocorrectionType.yes
        control.keyboardType = UIKeyboardType.default
        control.returnKeyType = UIReturnKeyType.done
        control.clearButtonMode = UITextField.ViewMode.whileEditing
        control.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return control
    }()
    
    let textStack: UIStackView = {
        let view = UIStackView()
        return view
    }()
    
    @objc func keyboardPressedOutside() {
           view.endEditing(true)
    }
    
    @objc func clearButtonWasPressed(){
        startLocation.text?.removeAll();
        endLocation.text?.removeAll();
        clearButton.setTitleColor(.gray, for: .disabled)
        clearButton.backgroundColor = .lightGray
        clearButton.isEnabled = false
        goButton.isEnabled = false;
    }
    @objc func goButtonWasPressed(){
       
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if(textField == endLocation && startLocation.hasText){
            goButton.isEnabled = true
            goButtonWasPressed()
        }
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if (textField.hasText) {
            clearButton.isEnabled = true
        }
    }
}

