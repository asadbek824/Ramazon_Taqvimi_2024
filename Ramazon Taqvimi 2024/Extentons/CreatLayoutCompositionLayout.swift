//
//  CreatLayoutCompositionLayout.swift
//  Ramazon Taqvimi 2024
//
//  Created by Asadbek Yoldoshev on 15/02/24.
//

import UIKit

extension UICollectionViewCompositionalLayout {
    
    static func creatLayout(
        itemWidth: NSCollectionLayoutDimension,
        itemHeight: NSCollectionLayoutDimension,
        itemContentInsert: NSDirectionalEdgeInsets = .init(
            top: 0,
            leading: 0,
            bottom: 0,
            trailing: 0
        ),
        groupWidth: NSCollectionLayoutDimension,
        groupHeight: NSCollectionLayoutDimension,
        groupContentInsert: NSDirectionalEdgeInsets = .init(
            top: 0,
            leading: 0,
            bottom: 0,
            trailing: 0
        ),
        headerWidth: NSCollectionLayoutDimension? = nil,
        headerHeight: NSCollectionLayoutDimension? = nil
    ) -> NSCollectionLayoutSection {
            
            let section: NSCollectionLayoutSection
            
            let itemSize = NSCollectionLayoutSize(
                widthDimension: itemWidth,
                heightDimension: itemHeight
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = itemContentInsert
            
            var boundarySupplementaryItems: [NSCollectionLayoutBoundarySupplementaryItem] = []
            
            if let headerWidth = headerWidth, let headerHeight = headerHeight {
                let headerSize = NSCollectionLayoutSize(
                    widthDimension: headerWidth,
                    heightDimension: headerHeight
                )
                let header = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top
                )
                boundarySupplementaryItems.append(header)
            }
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: groupWidth,
                heightDimension: groupHeight
            )
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            group.contentInsets = groupContentInsert
            
            section = NSCollectionLayoutSection(group: group)
            section.boundarySupplementaryItems = boundarySupplementaryItems
            
            return section
    }
}
