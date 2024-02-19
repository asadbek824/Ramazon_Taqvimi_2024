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
        
        layer.cornerRadius = 16
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
