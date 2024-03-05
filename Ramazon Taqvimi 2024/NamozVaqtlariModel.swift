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

enum NamozVaqtlari: Int, CaseIterable {
    case ogizYopish
    case bomdodChiqish
    case peshin
    case asr
    case shom
    case xufton
    
    func getImage() -> UIImage? {
        switch self {
        case .ogizYopish: return .init(systemName: "applelogo")
        case .bomdodChiqish: return .init(systemName: "applelogo")
        case .peshin: return .init(systemName: "applelogo")
        case .asr: return .init(systemName: "applelogo")
        case .shom: return .init(systemName: "applelogo")
        case .xufton: return .init(systemName: "applelogo")
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
