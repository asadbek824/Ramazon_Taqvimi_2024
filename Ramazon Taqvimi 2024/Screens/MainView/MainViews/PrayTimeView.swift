//
//  PrayTimeView.swift
//  Ramazon Taqvimi 2024
//
//  Created by Asadbek Yoldoshev on 02/03/24.
//

import UIKit

final class PrayTimeView: UIStackView {

    private let imageView = UIImageView()
    private let prayerNameLabel = UILabel()
    private let prayTimeLabel = UILabel()
    
    private let blurEffectView = UIVisualEffectView(
        effect: UIBlurEffect(
            style: .extraLight)
    )
    
    init(type: NamozVaqtlari, prayerTimes: [String]) {
        super.init(frame: .zero)
    
        setConstraint(.height, from: self, 70)
        axis = .horizontal
        alignment = .center
        spacing = 10
        backgroundColor = .clear
        layer.cornerRadius = 16
        layoutMargins = .init(top: 0, left: 5, bottom: 0, right: 5)
        isLayoutMarginsRelativeArrangement = true
        
        imageView.setConstraint(.width, from: self, 50)
        imageView.setConstraint(.height, from: self, 50)
        imageView.tintColor = .appColor.textColor
                
        prayTimeLabel.setConstraint(.width, from: self, 50)
        
        imageView.image = type.getImage()
        prayerNameLabel.text = type.getPrayerTimeName()
        prayTimeLabel.text = prayerTimes[type.rawValue]
        
        addArrangedSubview(imageView)
        addArrangedSubview(prayerNameLabel)
        addArrangedSubview(prayTimeLabel)
        insertSubview(blurEffectView, at: 0)
        
        blurEffectView.clipsToBounds = true
        blurEffectView.layer.cornerRadius = 15
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            blurEffectView.topAnchor.constraint(equalTo: topAnchor),
            blurEffectView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: trailingAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
