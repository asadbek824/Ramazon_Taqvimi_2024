//
//  ProgressView.swift
//  Ramazon Taqvimi 2024
//
//  Created by Asadbek Yoldoshev on 05/03/24.
//

import UIKit

final class ProgressView: UIView {
    
    let circularProgressView = CircularProgressView(
        frame: CGRect(x: 0, y: 0, width: 130, height: 130),
        lineWidth: 8,
        rounded: true
    )
    
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
        
        addSubview(circularProgressView)
        
        circularProgressView.setConstraint(.xCenter, from: self, 0)
        circularProgressView.setConstraint(.yCenter, from: self, 0)
        circularProgressView.setConstraint(.height, from: self, 130)
        circularProgressView.setConstraint(.width, from: self, 130)
        
        circularProgressView.progressColor = UIColor.appColor.textColor
        circularProgressView.trackColor = UIColor.systemGray
        
//        circularProgressView.animateProgress(duration: 10)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
