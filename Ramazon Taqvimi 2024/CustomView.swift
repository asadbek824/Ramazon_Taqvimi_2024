//
//  CustomView.swift
//  Ramazon Taqvimi 2024
//
//  Created by Asadbek Yoldoshev on 24/02/24.
//

import UIKit

final class CustomView: UIView {
    
    private let img = UIImageView()
    private let title = UILabel()
    private let time = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        toFormUIElements()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension CustomView {
    
    private func toFormUIElements() {
        
        
    }
        
    func setTime(data: String ) {
        
        time.text = data
        
        print(data)
    }
}


struct NamazTime {
    
    let time: String
}
