//
//  ViewController.swift
//  kvdemidenkoPW7
//
//  Created by Ксения Демиденко on 28.01.2022.
//

import UIKit
import CoreLocation
import MapKit

final class ViewController: UIViewController, MKMapViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.frame = CGRect(x: 10, y: 30, width: view.frame.size.width, height: view.frame.size.height)
        mapView.mapType = MKMapType.standard
        mapView.center = view.center
        view.addSubview(mapView)
        buttonsStackView.addArrangedSubview(goButton)
        buttonsStackView.addArrangedSubview(clearButton)
        view.addSubview(buttonsStackView)
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        buttonsStackView.centerYAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -50).isActive = true
        configureUI();
        
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
    
    private func configureUI() {
    }
    
    
    private let goButton: CustomButton = {
        let button = CustomButton(with: CustomButtonViewModel(title: "Go", backgroundColor: .systemBlue, textColor: .white))
        button.widthAnchor.constraint(equalToConstant: 130.0).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        button.layer.cornerRadius = 20
//        button.addTarget(self, action: #selector(goButtonWasPressed), for: .touchUpInside)
        return button
    }()
    
    private let clearButton: CustomButton = {
        let button = CustomButton(with: CustomButtonViewModel(title: "Clear", backgroundColor: UIColor.darkGray, textColor: UIColor.white))
        button.widthAnchor.constraint(equalToConstant: 130.0).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        button.layer.cornerRadius = 20
//        button.addTarget(self, action: #selector(clearButtonWasPressed), for: .touchUpInside)
        return button
    }()
    
    private let buttonsStackView: UIStackView = {
        let view = UIStackView()
        return view
    }()
    
    
}

