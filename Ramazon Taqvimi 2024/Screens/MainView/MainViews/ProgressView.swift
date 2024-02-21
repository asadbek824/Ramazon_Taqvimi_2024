//
//  ProgressView.swift
//  Ramazon Taqvimi 2024
//
//  Created by Asadbek Yoldoshev on 16/02/24.
//

import UIKit

final class ProgressView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        let circularProgressView = CircularProgressView(frame: CGRect(
            x: 0,
            y: 5,
            width: 150,
            height: 150
        ), lineWidth: 15, rounded: true)
        
        circularProgressView.progressColor = UIColor.red
        circularProgressView.trackColor = UIColor.green
        
        addSubview(circularProgressView)
        
        circularProgressView.setProgress(duration: 10, to: 1.0)
        
        layer.cornerRadius = 16
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
