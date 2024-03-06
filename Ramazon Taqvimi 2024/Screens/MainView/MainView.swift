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
    private let stackView = UIStackView()
    let progressStackView = UIStackView()
    let openAndCloseView = OpenAndCloseView()
    let prayerTimesView = UIStackView()
    let circularProgressView = CircularProgressView(
        frame: CGRect(x: 0, y: 0, width: 130, height: 130),
        lineWidth: 8,
        rounded: true
    )
    
    let alert = UIAlertController(
        title: "Ilova ishlashi uchun joylashuvga ruxsat bering",
        message: "Iltimos ilovamiz ishlashi uchun joylashuv sozlamalariga ruxsat bering",
        preferredStyle: .alert
    )
    
    let settingsAction = UIAlertAction(title: "Sozlamalarga o'tish", style: .default) { (_) -> Void in

            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }

            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl)
            }
        }
    
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
        scrollView.setConstraint(.left, from: self, 0)
        scrollView.setConstraint(.right, from: self, 0)
        scrollView.topAnchor.constraint(
            equalTo: self.safeAreaLayoutGuide.topAnchor
        ).isActive = true
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
        
        openAndCloseView.setConstraint(
            .width, from: progressStackView,
            UIScreen.main.bounds.width / 2
        )
    }
    
    private func setUpProgressView() {
        
        let progressView = UIView()
        
        progressStackView.addArrangedSubview(progressView)
        
        let blurEffectView: UIVisualEffectView = {
            let blurEffect = UIBlurEffect(style: .extraLight)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            return blurEffectView
        }()
        
        progressView.addSubview(blurEffectView)
        
        blurEffectView.setConstraint(.top, from: progressView, 0)
        blurEffectView.setConstraint(.left, from: progressView, 0)
        blurEffectView.setConstraint(.right, from: progressView, 0)
        blurEffectView.setConstraint(.bottom, from: progressView, 0)
        
        progressView.layer.cornerRadius = 16
        progressView.clipsToBounds = true
        
        progressView.addSubview(circularProgressView)
        
        circularProgressView.setConstraint(.xCenter, from: progressView, 0)
        circularProgressView.setConstraint(.yCenter, from: progressView, 0)
        circularProgressView.setConstraint(.height, from: progressView, 130)
        circularProgressView.setConstraint(.width, from: progressView, 130)
        
        circularProgressView.progressColor = UIColor.appColor.textColor
        circularProgressView.trackColor = UIColor.systemGray
    }
    
    private func setUpPrayerTimesView() {
        
        stackView.addArrangedSubview(prayerTimesView)
        
        prayerTimesView.axis = .vertical
        prayerTimesView.spacing = 8
        prayerTimesView.layoutMargins = .init(top: 16, left: 16, bottom: 16, right: 16)
        prayerTimesView.isLayoutMarginsRelativeArrangement = true
        
        prayerTimesView.setConstraint(.width, from: stackView, UIScreen.main.bounds.width)
    }
    
    func setUpPrayerViews(prayerTimes: [String]) {
        NamozVaqtlari.allCases.forEach {
            prayerTimesView.addArrangedSubview(PrayTimeView(type: $0, prayerTimes: prayerTimes))
        }
    }
}


