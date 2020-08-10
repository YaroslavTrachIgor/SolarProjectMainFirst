//
//  PlanetsMenuTableViewControllerCollectionViewDelegatesExtension.swift
//  SolarProject
//
//  Created by Yaroslav on 03.07.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation
import UIKit

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource extension
extension PlanetsMenuTableViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        ///Setup numbe rOf Items In Section
        if collectionView.tag == 0 {
            return setupNemberOfRowsInSection()
        } else {
            return presenter.setupMoreItemsNumberOfRows()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImagesCollectionViewCell", for: indexPath) as! ImagesCollectionViewCell
            
            ///Setup cell
            setupImageCell(cell: cell, indexPath: indexPath)
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoreCollectionViewCell", for: indexPath) as! MoreCollectionViewCell
            
            ///Setup cell
            setupMoreCell(cell: cell, indexPath: indexPath)
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 1 {
            performSegue(withIdentifier: presenter.setupSegues(row: indexPath.row), sender: self)
        }
    }
}
