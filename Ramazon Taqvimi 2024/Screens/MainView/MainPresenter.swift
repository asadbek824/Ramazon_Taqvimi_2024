//
//  MainPresenter.swift
//  Ramazon Taqvimi 2024
//
//  Created by Asadbek Yoldoshev on 15/02/24.
//

import UIKit

protocol MainPresenterable {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell
}

final class MainPresenter: MainPresenterable {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        MainViewSectionType.allCases.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        guard let sectionType = MainViewSectionType(rawValue: section) else { return .zero }
        
        return sectionType.getNumberOfItems()
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        guard let sectionType = MainViewSectionType(rawValue: indexPath.section) else {
            return UICollectionViewCell()
        }
        
        switch sectionType {
        case .scheduleOfDays:
            
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "cellDays",
                for: indexPath
            ) as? ScheduleOfDaysCell else { return UICollectionViewCell() }
            
            return cell
        case .prayerTimes:
            
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "cellTimes",
                for: indexPath
            ) as? PrayerTimesCell else { return UICollectionViewCell() }
            
            return cell
        case .sunrise:
            
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "cellSun",
                for: indexPath
            ) as? SunriseAndSunsetCell else { return UICollectionViewCell() }
            
            return cell
        case .sunset:
            
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "cellSun",
                for: indexPath
            ) as? SunriseAndSunsetCell else { return UICollectionViewCell() }
            
            return cell
        }
    }
}
