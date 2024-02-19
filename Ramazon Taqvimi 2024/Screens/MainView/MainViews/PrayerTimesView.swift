//
//  PrayerTimesView.swift
//  Ramazon Taqvimi 2024
//
//  Created by Asadbek Yoldoshev on 16/02/24.
//

import UIKit

final class PrayerTimesView: UIView {
    
    //MARK: - UIElements
    private let stackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpStackView()
        setUpBomdodView()
        setUpSunriseView()
        setUpPeshinView()
        setUpAsrView()
        setUpShomView()
        setUpXuftonView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PrayerTimesView {
    
    private func setUpStackView() {
        
        addSubview(stackView)
        
        stackView.setConstraint(.bottom, from: self, 0)
        stackView.setConstraint(.top, from: self, 0)
        stackView.setConstraint(.left, from: self, 0)
        stackView.setConstraint(.right, from: self, 0)
        
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.layoutMargins = .init(top: 16, left: 16, bottom: 16, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
    }
    
    private func setUpBomdodView() {
        
        let bomdodView = setUpPrayerView(image: "bell", title: "Bomdod vaqti (saxarlik):", time: "00:00")
        
        stackView.addArrangedSubview(bomdodView)
        
        bomdodView.setConstraint(.height, from: stackView, 70)
    }
    
    private func setUpSunriseView() {
        
        let sunriseView = setUpPrayerView(image: "bell", title: "Quyosh chiqishi:", time: "00:00")
        
        stackView.addArrangedSubview(sunriseView)
        
        sunriseView.setConstraint(.height, from: stackView, 70)
    }
    
    private func setUpPeshinView() {
        
        let peshinView = setUpPrayerView(image: "peshin", title: "Peshin vaqti:", time: "00:00")
        
        stackView.addArrangedSubview(peshinView)
        
        peshinView.setConstraint(.height, from: stackView, 70)
    }
    
    private func setUpAsrView() {
        
        let asrView = setUpPrayerView(image: "bell", title: "Asr vaqti:", time: "00:00")
        
        stackView.addArrangedSubview(asrView)
        
        asrView.setConstraint(.height, from: stackView, 70)
    }
    
    private func setUpShomView() {
        
        let shomView = setUpPrayerView(image: "shom", title: "Shom vaqti (iftorlik):", time: "00:00")
        
        stackView.addArrangedSubview(shomView)
        
        shomView.setConstraint(.height, from: stackView, 70)
    }
    
    private func setUpXuftonView() {
        
        let xuftonView = setUpPrayerView(image: "bell", title: "Xufton vaqti:", time: "00:00")
        
        stackView.addArrangedSubview(xuftonView)
        
        xuftonView.setConstraint(.height, from: stackView, 70)
    }
}
