//
//  MainViewSectionType.swift
//  Ramazon Taqvimi 2024
//
//  Created by Asadbek Yoldoshev on 15/02/24.
//

import UIKit

enum MainViewSectionType: Int, CaseIterable {
    case scheduleOfDays = 0
    case prayerTimes = 1
    case sunrise = 2
    case sunset = 3
}

extension MainViewSectionType {
    func getNumberOfItems() -> Int {
        switch self {
        case .scheduleOfDays:
            1
        case .prayerTimes:
            6
        case .sunrise:
            1
        case .sunset:
            1
        }
    }
}
