//
//  PrayerTimesView.swift
//  Ramazon Taqvimi 2024
//
//  Created by Asadbek Yoldoshev on 16/02/24.
//

//
//  PrayerTimesView.swift
//  Ramazon Taqvimi 2024
//
//  Created by Asadbek Yoldoshev on 16/02/24.
//

import UIKit
import CoreLocation

enum NamozVaqtlari: Int, CaseIterable {
    case ogizYopish
    case bomdodChiqish
    case peshin
    case asr
    case shom
    case xufton
    
    func getImage() -> UIImage? {
        switch self {
        case .ogizYopish: return .init(named: "bomdod")
        case .bomdodChiqish: return .init(named: "quyoshchiqishi")
        case .peshin: return .init(named: "peshin")
        case .asr: return .init(named: "asr")
        case .shom: return .init(named: "shom")
        case .xufton: return .init(named: "xufton")
        }
    }
    
    func getPrayerTimeName() -> String {
        switch self {
        case .ogizYopish: return "Bomdod vaqti (saxarlik)"
        case .bomdodChiqish: return "Quyosh chiqishi"
        case .peshin: return "Peshin vaqti"
        case .asr: return "Asr vaqti"
        case .shom: return "Shom vaqti (iftorlik)"
        case .xufton: return "Xufton vaqti"
        }
    }
}


final class NamozVaqtlarManager {
    
    private var namozVaqtlari: [String] = []
    
    private var userLocation: CLLocationCoordinate2D = .init(latitude: 41, longitude: 69)
    
    let startDate = 11
    
    static let shared = NamozVaqtlarManager()
    
    func setNamozVaqtlari(times: [String]) {
        self.namozVaqtlari = times
    }
    
    func getNamozVaqtlari() -> [String] {
        namozVaqtlari
    }
    
    
    func setCoordinate(_ coordinate: CLLocationCoordinate2D) {
        self.userLocation = coordinate
    }
    
    func getCoordinate() -> CLLocationCoordinate2D {
        userLocation
    }
}
