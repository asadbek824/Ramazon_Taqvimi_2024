//
//  MainView.swift
//  Ramazon Taqvimi 2024
//
//  Created by Asadbek Yoldoshev on 15/02/24.
//

import UIKit

final class MainView: UIView {
    
    //MARK: - UIElements
    private let scrollView = UIScrollView()
    private let progressStackView = UIStackView()
    private let stackView = UIStackView()
    private let openAndCloseView = OpenAndCloseView()
    private let progressView = ProgressView()
    private let prayerTimesView = PrayerTimesView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let backgroundImage = UIImageView()
        
        addSubview(backgroundImage)
        
        backgroundImage.setConstraint(.bottom, from: self, 0)
        backgroundImage.setConstraint(.right, from: self, 0)
        backgroundImage.setConstraint(.left, from: self, 0)
        backgroundImage.setConstraint(.top, from: self, 0)
        
        backgroundImage.image = UIImage(named: "ramadanPicture")
        
        setUpScrollView()
        setUpStackView()
        setUpProgressStackView()
        setUpOpenAndCloseView()
        setUpProgressView()
        setUpPrayerTimesView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainView {
    
    private func setUpScrollView() {
        
        addSubview(scrollView)
        
        scrollView.setConstraint(.bottom, from: self, 0)
        scrollView.setConstraint(.top, from: self, 0)
        scrollView.setConstraint(.left, from: self, 0)
        scrollView.setConstraint(.right, from: self, 0)
    }
    
    private func setUpStackView() {
        
        scrollView.addSubview(stackView)
        
        stackView.setConstraint(.bottom, from: scrollView, 0)
        stackView.setConstraint(.left, from: scrollView, 0)
        stackView.setConstraint(.right, from: scrollView, 0)
        stackView.setConstraint(.top, from: scrollView, 0)
        
        stackView.axis = .vertical
    }
    
    private func setUpProgressStackView() {
        
        stackView.addArrangedSubview(progressStackView)
        
        progressStackView.setConstraint(.width, from: stackView, UIScreen.main.bounds.width)
        
        progressStackView.axis = .horizontal
        progressStackView.spacing = 8
        progressStackView.layoutMargins = .init(top: 0, left: 16, bottom: 0, right: 16)
        progressStackView.isLayoutMarginsRelativeArrangement = true
    }
    
    private func setUpOpenAndCloseView() {
        
        progressStackView.addArrangedSubview(openAndCloseView)
        
        openAndCloseView.setConstraint(.width, from: progressStackView, UIScreen.main.bounds.width / 2)
    }
    
    private func setUpProgressView() {
        
        progressStackView.addArrangedSubview(progressView)
    }
    
    private func setUpPrayerTimesView() {
        
        stackView.addArrangedSubview(prayerTimesView)
        
        prayerTimesView.setConstraint(.width, from: stackView, UIScreen.main.bounds.width)
    }
}
