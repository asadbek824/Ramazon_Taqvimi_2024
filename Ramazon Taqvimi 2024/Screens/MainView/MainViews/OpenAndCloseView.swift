//
//  OpenAndCloseView.swift
//  Ramazon Taqvimi 2024
//
//  Created by Asadbek Yoldoshev on 16/02/24.
//

import UIKit

final class OpenAndCloseView: UIView {
    
    private let stackView = UIStackView()
    private let openMouthLabel = UILabel()
    private let openMouthTimeLabel = UILabel()
    private let closeMouthLabel = UILabel()
    private let closeMouthTimeLabel = UILabel()
    private let prayClass = PrayerTime()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let blurEffectView: UIVisualEffectView = {
            let blurEffect = UIBlurEffect(style: .extraLight)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            return blurEffectView
        }()
        
        addSubview(blurEffectView)
        
        blurEffectView.setConstraint(.top, from: self, 0)
        blurEffectView.setConstraint(.left, from: self, 0)
        blurEffectView.setConstraint(.right, from: self, 0)
        blurEffectView.setConstraint(.bottom, from: self, 0)
        
        layer.cornerRadius = 16
        clipsToBounds = true
        
        setUpStackView()
        setUpOpenMouth()
        setUpCloseMouth()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension OpenAndCloseView {
    
    private func setUpStackView() {
        
        addSubview(stackView)
        
        stackView.setConstraint(.bottom, from: self, 0)
        stackView.setConstraint(.top, from: self, 0)
        stackView.setConstraint(.left, from: self, 0)
        stackView.setConstraint(.right, from: self, 0)
        
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.layoutMargins = .init(top: 16, left: 8, bottom: 16, right: 8)
        stackView.isLayoutMarginsRelativeArrangement = true
    }
    
    private func setUpOpenMouth() {
        
        stackView.addArrangedSubview(openMouthLabel)
        
        openMouthLabel.text = "Og'iz ochish vaqti"
        openMouthLabel.font = .systemFont(ofSize: 20)
        
        stackView.addArrangedSubview(openMouthTimeLabel)

        openMouthTimeLabel.font = .systemFont(ofSize: 22)
    }
    
    private func setUpCloseMouth() {
        
        stackView.addArrangedSubview(closeMouthLabel)
        
        closeMouthLabel.text = "Og'iz yopish vaqti"
        closeMouthLabel.font = .systemFont(ofSize: 20)
        
        stackView.addArrangedSubview(closeMouthTimeLabel)
        closeMouthTimeLabel.font = .systemFont(ofSize: 22)
    }
    
    func updateTimes(_ saxarlikString: String,_ iftorlikString: String) {
        openMouthTimeLabel.text = saxarlikString
        closeMouthTimeLabel.text = iftorlikString
    }
}
