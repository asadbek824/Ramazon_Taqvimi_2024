//
//  UICordinate.swift
//  Ramazon Taqvimi 2024
//
//  Created by Asadbek Yoldoshev on 23/02/24.
//

import Foundation
import Adhan

extension Date {
    func prayerTimes(for coordinates: Coordinates, calculationParameters: CalculationParameters) -> PrayerTimes? {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: self)
        return PrayerTimes(coordinates: coordinates, date: dateComponents, calculationParameters: calculationParameters)
    }
}
