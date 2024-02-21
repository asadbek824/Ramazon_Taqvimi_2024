//
//  UIView.swift
//  Ramazon Taqvimi 2024
//
//  Created by Asadbek Yoldoshev on 15/02/24.
//

import UIKit

//MARK: - extension to UIView Constraint
extension UIView {
    enum Anchor {
        case left
        case right
        case top
        case bottom
        case width
        case height
        case xCenter
        case yCenter
    }
    
    func setConstraint(_ anchor: Anchor, from view: UIView, _ constraint: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        switch anchor {
        case .left:
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constraint).isActive = true
        case .right:
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constraint).isActive = true
        case .top:
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: constraint).isActive = true
        case .bottom:
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -constraint).isActive = true
        case .width:
            self.widthAnchor.constraint(equalToConstant: constraint).isActive = true
        case .height:
            self.heightAnchor.constraint(equalToConstant: constraint).isActive = true
        case .xCenter:
            self.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant:  constraint).isActive = true
        case .yCenter:
            self.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constraint).isActive = true
        }
    }
}

// MARK: - creat UIView
extension UIView {
    func setUpPrayerView(image: String, title: String, time: String) -> UIView {
        
        let view = UIView()
        
        view.backgroundColor = .appColor.timerColor
        view.layer.cornerRadius = 16
        
        let titleLabel = UILabel()

        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 16)
        
        let timeLabel = UILabel()
        timeLabel.text = time
        timeLabel.font = .systemFont(ofSize: 16)
        timeLabel.textColor = .gray
        
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: image)
        
        view.addSubview(imageView)
        
        imageView.setConstraint(.left, from: view, 16)
        imageView.setConstraint(.yCenter, from: view, 0)
        imageView.setConstraint(.height, from: view, 48)
        imageView.setConstraint(.width, from: view, 48)
        
        view.addSubview(titleLabel)
        
        titleLabel.setConstraint(.yCenter, from: view, 0)
        titleLabel.leadingAnchor.constraint(
            equalTo: imageView.trailingAnchor,
            constant: 16
        ).isActive = true
        
        view.addSubview(timeLabel)
        
        timeLabel.setConstraint(.yCenter, from: view, 0)
        timeLabel.trailingAnchor.constraint(
            equalTo: view.trailingAnchor,
            constant: -24
        ).isActive = true
        
        return view
    }
}

