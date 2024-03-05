//
//  MainViewController.swift
//  Ramazon Taqvimi 2024
//
//  Created by Asadbek Yoldoshev on 14/02/24.
//

import UIKit
import CoreLocation

enum RamadanType {
    case saharlik
    case iftorlik
}

final class MainViewController: UIViewController {
    
    //MARK: - UIElements
    private let mainView = MainView()
    private let prayerTime = PrayerTime()
    private var coordinate: CLLocationCoordinate2D?
    private let currentDate = Date()
    
    private var fastingTime = 0
    private var notFastingTime = 0
    private var currentTime = 0
    private var saharlikSecond = 0
    private var iftorlikSecond = 0
    private let daylySecond: Int = 86400
    
    private var locationManager: CLLocationManager?
    
    override func loadView() {
        super.loadView()
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        locationManager?.startUpdatingLocation()
        
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavBar()
        mainView.circularProgressView.delegate = self
    }
    
    private func setupRamadanTime() {
        
        guard let coordinate else { return }
        
        var components = Calendar.current.dateComponents([.day, .month], from: Date())
        
        let times = prayerTime.main(
            coordinate: coordinate,
            month: components.month ?? 3,
            day: components.day ?? 1
        )
        
        let formatedTimes = times.map { formatTime($0) }
        
        let saxarlik = times[NamozVaqtlari.ogizYopish.rawValue]
        let iftorlik = times[NamozVaqtlari.shom.rawValue]
        
        let saharlikHourInt = formatNumber(Int(saxarlik))
        let saharlikMinutInt = formatNumber(Int(saxarlik.truncatingRemainder(dividingBy: 1) * 60))
        let saharlikSecond = (saharlikHourInt * 3600) + (saharlikMinutInt * 60)
        self.saharlikSecond = saharlikSecond
        
        let iftorlikHourInt = formatNumber(Int(iftorlik))
        let iftorlikMinutInt = formatNumber(Int(iftorlik.truncatingRemainder(dividingBy: 1) * 60))
        let iftorlikSecond = (iftorlikHourInt * 3600) + (iftorlikMinutInt * 60)
        self.iftorlikSecond = iftorlikSecond
        
        let saxarlikString = formatedTimes[NamozVaqtlari.ogizYopish.rawValue]
        let iftorlikString = formatedTimes[NamozVaqtlari.shom.rawValue]
         
        fastingTime = iftorlikSecond - saharlikSecond
        notFastingTime = daylySecond - (iftorlikSecond - saharlikSecond)
        
        mainView.openAndCloseView.updateTimes(iftorlikString, saxarlikString)
//        mainView.circularProgressView.animateProgress(duration: notFastingTime)
        
        let calendar = Calendar.current

        components = calendar.dateComponents([.hour, .minute, .second], from: currentDate)

        if let hour = components.hour,
           let minute = components.minute,
           let second = components.second {
            currentTime = 3600 * hour + 60 * minute + second
        }
        
        if currentTime >= saharlikSecond, currentTime <= iftorlikSecond {
            mainView.circularProgressView.openAndCloseLabel.text = "Og'iz \nochishgacha"
            mainView.circularProgressView.animateProgress(duration: Double(fastingTime), fromValue: 0.0)
        } else if currentTime >= iftorlikSecond {
            
            let duration = daylySecond - currentTime + saharlikSecond
            
            let onePercent = notFastingTime / 100
//            let fromValue = duration
            print(duration, onePercent)
            
            mainView.circularProgressView.openAndCloseLabel.text = "Og'iz \nyopishgacha"
            mainView.circularProgressView.animateProgress(
                duration: Double(duration),
                fromValue: Double(duration / notFastingTime)
            )
        } else {
            
            let duration: Double = Double(saharlikSecond - currentTime)
            
            
            let onePercent: Double = Double(notFastingTime) / 100
            let fromValue = (duration / onePercent) / 100
            print(duration, onePercent)
            
            mainView.circularProgressView.openAndCloseLabel.text = "Og'iz \nyopishgacha"
            mainView.circularProgressView.animateProgress(
                duration: duration,
                fromValue: Double(fromValue)
            )
            print(fromValue)
        }
        
    }
    
    @objc private func rightBarButtonTapped() {
        navigationController?.pushViewController(TasbehViewController(), animated: true)
    }
}

extension MainViewController {
    
    private func setUpNavBar() {
        
        title = "Namoz vaqtlari"
        
        let navigationBarApperance = UINavigationBarAppearance()
        
        navigationBarApperance.configureWithOpaqueBackground()
        navigationBarApperance.backgroundColor = .appColor.navigatioColor
        
        let rightBarButton = UIBarButtonItem(
            image: UIImage(named: "tasbih"),
            style: .plain,
            target: self,
            action: #selector(rightBarButtonTapped)
        )
        
        rightBarButton.tintColor = .black
        navigationItem.rightBarButtonItem = rightBarButton
        
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarApperance
    }
}

extension MainViewController: CLLocationManagerDelegate {
    func locationManager(
    _ manager: CLLocationManager,
    didChangeAuthorization status: CLAuthorizationStatus
    ) {
        if status == .authorizedWhenInUse, let coordinate = manager.location?.coordinate {
            let prayerTimes = PrayerTime()
            let components = Calendar.current.dateComponents([.day, .month], from: Date())
            
            let times = prayerTimes.main(
                coordinate: coordinate,
                month: components.month ?? 3,
                day: components.day ?? 1
            ).map { formatTime($0) }
            self.coordinate = coordinate
            mainView.setUpPrayerViews(prayerTimes: times)
            
            setupRamadanTime()
        }
    }
}

extension MainViewController: ProgressVieDelegate {
    
    func didEndProgress() {
        setupRamadanTime()
    }
}
