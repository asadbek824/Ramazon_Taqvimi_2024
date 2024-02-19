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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        layer.cornerRadius = 16
        
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
        stackView.layoutMargins = .init(top: 16, left: 0, bottom: 20, right: 0)
        stackView.isLayoutMarginsRelativeArrangement = true
    }
    
    private func setUpOpenMouth() {
        
        stackView.addArrangedSubview(openMouthLabel)
        
        openMouthLabel.text = "Og'iz ochish vaqti"
        openMouthLabel.font = .systemFont(ofSize: 24)
        
        stackView.addArrangedSubview(openMouthTimeLabel)
        
        openMouthTimeLabel.text = "00:00"
        openMouthTimeLabel.font = .systemFont(ofSize: 26)
    }
    
    private func setUpCloseMouth() {
        
        stackView.addArrangedSubview(closeMouthLabel)
        
        closeMouthLabel.text = "Og'iz yopish vaqti"
        closeMouthLabel.font = .systemFont(ofSize: 24)
        
        stackView.addArrangedSubview(closeMouthTimeLabel)
        
        closeMouthTimeLabel.text = "00:00"
        closeMouthTimeLabel.font = .systemFont(ofSize: 26)
    }
}
