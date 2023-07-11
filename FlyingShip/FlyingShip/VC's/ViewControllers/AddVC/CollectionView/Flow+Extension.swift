//
//  Flow+Extension.swift
//  FlyingShip
//
//  Created by Nor1 on 11.07.2023.
//

import Foundation
import UIKit

private extension CGFloat {
    static let itemSize = 100.0
    static let offset10 = 10.0
    static let estimated = 3000.0
    static let fractional05 = 0.5
    static let sectionOffset = 15.0
    static let sectionOffsetTop = 5.0
    
}

extension UICollectionViewFlowLayout {
    static func playerAndBackgroundFlow() -> UICollectionViewCompositionalLayout {
        let flowLayout = UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            switch sectionNumber {
            case 0 :
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(CGFloat.itemSize), heightDimension: .absolute(CGFloat.itemSize)))
                item.contentInsets.trailing = CGFloat.offset10
                item.contentInsets.leading = CGFloat.offset10
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .estimated(CGFloat.estimated), heightDimension: .absolute(CGFloat.itemSize)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.boundarySupplementaryItems = [ NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(25)), elementKind: "\(HeaderCollectionView.self)", alignment: .topLeading)]
                section.contentInsets.top = CGFloat.sectionOffsetTop
                section.contentInsets.leading = CGFloat.sectionOffset
                section.contentInsets.bottom = CGFloat.offset10*2
                return section
            default:
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(CGFloat.itemSize), heightDimension: .absolute(CGFloat.itemSize)))
                item.contentInsets.trailing = CGFloat.offset10
                item.contentInsets.leading = CGFloat.offset10
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .estimated(CGFloat.estimated), heightDimension: .absolute(CGFloat.itemSize)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.boundarySupplementaryItems = [ NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(25)), elementKind: "\(HeaderCollectionView.self)", alignment: .topLeading)]
                section.contentInsets.top = CGFloat.sectionOffsetTop
                section.contentInsets.leading = CGFloat.sectionOffset
                return section
            }
        }
        return flowLayout
    }
}
