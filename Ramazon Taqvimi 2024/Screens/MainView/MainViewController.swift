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
    
    private var fastingTime = 0.0
    private var notFastingTime = 0.0
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        locationManager?.requestWhenInUseAuthorization()
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
         
        fastingTime = Double(iftorlikSecond - saharlikSecond)
        notFastingTime = Double(daylySecond - (iftorlikSecond - saharlikSecond))
        
        mainView.openAndCloseView.updateTimes(iftorlikString, saxarlikString)
        
        let calendar = Calendar.current

        components = calendar.dateComponents([.hour, .minute, .second], from: currentDate)

        if let hour = components.hour,
           let minute = components.minute,
           let second = components.second {
            currentTime = 3600 * hour + 60 * minute + second
        }
        
        if currentTime >= saharlikSecond, currentTime <= iftorlikSecond {
            
            let duration = Double(iftorlikSecond - currentTime)
            
            let fromValue = 1 - (duration / fastingTime)
            
            mainView.circularProgressView.openAndCloseLabel.text = "Og'iz \nochishgacha"
            mainView.circularProgressView.animateProgress(
                duration: duration,
                fromValue: fromValue
            )
            
        } else if currentTime >= iftorlikSecond {
            
            let duration = Double(daylySecond - currentTime + saharlikSecond)
            
            let fromValue = 1 - (duration / notFastingTime)
            
            mainView.circularProgressView.openAndCloseLabel.text = "Og'iz \nyopishgacha"
            mainView.circularProgressView.animateProgress(
                duration: Double(duration),
                fromValue: fromValue
            )
        } else {
            
            let duration = Double(saharlikSecond - currentTime)
            
            let fromValue = 1 - (duration / notFastingTime)
            
            mainView.circularProgressView.openAndCloseLabel.text = "Og'iz \nyopishgacha"
            mainView.circularProgressView.animateProgress(
                duration: duration,
                fromValue: Double(fromValue)
            )
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
        if status == .denied || status == .restricted || status == .notDetermined {
            mainView.progressStackView.isHidden = true
            mainView.prayerTimesView.isHidden = true
            mainView.alert.addAction(mainView.settingsAction)
            present(mainView.alert, animated: true)
        }
        if let coordinate = manager.location?.coordinate {
            mainView.alert.dismiss(animated: true)
            mainView.progressStackView.isHidden = false
            mainView.prayerTimesView.isHidden = false
            
            let prayerTimes = PrayerTime()
            let components = Calendar.current.dateComponents([.day, .month], from: Date())
            
            let times = prayerTimes.main(
                coordinate: coordinate,
                month: components.month ?? 3,
                day: components.day ?? 1
            ).map { formatTime($0) }
            
            NamozVaqtlarManager.shared.setNamozVaqtlari(times: times)
            NamozVaqtlarManager.shared.setCoordinate(coordinate)
            
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
