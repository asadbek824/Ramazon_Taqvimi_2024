//
//  SettingsVC.swift
//  Ramazon Taqvimi 2024
//
//  Created by islombek on 16/02/24.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.layoutMargins = .init(top: 10, left: 10, bottom: 10, right: 10)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let ogizOchishView = UIView()
    private let ogizYopishView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appColor.primary
        
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        setUpStackView()
    }
}

extension ProfileViewController {
    
    private func setUpStackView() {
        
        stackView.addArrangedSubview(ogizOchishView)
        stackView.addArrangedSubview(ogizYopishView)
        
        ogizOchishView.translatesAutoresizingMaskIntoConstraints = false
        ogizOchishView.heightAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5).isActive = true
        ogizOchishView.backgroundColor = .blue
        
        // Add labels to ogizOchishView
        let label1 = UILabel()
        label1.text = "Label 1 Ochish"
        label1.textAlignment = .center
        label1.textColor = .white
        label1.font = UIFont.systemFont(ofSize: 16)
        ogizOchishView.addSubview(label1)
        
        let label2 = UILabel()
        label2.text = "Label 2 Ochish"
        label2.textAlignment = .center
        label2.textColor = .white
        label2.font = UIFont.systemFont(ofSize: 16)
        ogizOchishView.addSubview(label2)
        
        let label3 = UILabel()
        label3.text = "Label 3 Ochish"
        label3.textAlignment = .center
        label3.textColor = .white
        label3.font = UIFont.systemFont(ofSize: 16)
        ogizOchishView.addSubview(label3)
        
        // Adjust constraints for labels in ogizOchishView
        NSLayoutConstraint.activate([
            label1.centerXAnchor.constraint(equalTo: ogizOchishView.centerXAnchor),
            label1.centerYAnchor.constraint(equalTo: ogizOchishView.centerYAnchor),
            label2.centerXAnchor.constraint(equalTo: ogizOchishView.centerXAnchor),
            label2.centerYAnchor.constraint(equalTo: ogizOchishView.centerYAnchor),
            label3.centerXAnchor.constraint(equalTo: ogizOchishView.centerXAnchor),
            label3.centerYAnchor.constraint(equalTo: ogizOchishView.centerYAnchor)
        ])
        
        // Add labels to ogizYopishView
        ogizYopishView.translatesAutoresizingMaskIntoConstraints = false
        ogizYopishView.heightAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5).isActive = true
        ogizYopishView.backgroundColor = .yellow

        let yopishLabel1 = UILabel()
        yopishLabel1.text = "Label 1 Yopish"
        yopishLabel1.textAlignment = .center
        yopishLabel1.textColor = .white
        yopishLabel1.font = UIFont.systemFont(ofSize: 16)
        ogizYopishView.addSubview(yopishLabel1)

        let yopishLabel2 = UILabel()
        yopishLabel2.text = "Label 2 Yopish"
        yopishLabel2.textAlignment = .center
        yopishLabel2.textColor = .white
        yopishLabel2.font = UIFont.systemFont(ofSize: 16)
        ogizYopishView.addSubview(yopishLabel2)

        let yopishLabel3 = UILabel()
        yopishLabel3.text = "Label 3 Yopish"
        yopishLabel3.textAlignment = .center
        yopishLabel3.textColor = .white
        yopishLabel3.font = UIFont.systemFont(ofSize: 16)
        ogizYopishView.addSubview(yopishLabel3)

        // Adjust constraints for labels in ogizYopishView
       
    }
}
