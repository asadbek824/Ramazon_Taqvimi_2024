//
//  SunriseAndSunsetCell.swift
//  Ramazon Taqvimi 2024
//
//  Created by Asadbek Yoldoshev on 15/02/24.
//

import UIKit

final class SunriseAndSunsetCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .appColor.textColor
        layer.cornerRadius = 16
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
