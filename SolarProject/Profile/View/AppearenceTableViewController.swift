//
//  AppearenceTableViewController.swift
//  SolarProject
//
//  Created by Yaroslav on 20.08.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import UIKit

//MARK: - AppearenceTableViewController main class
final class AppearenceTableViewController: UITableViewController {

    //MARK: Fileprivate
    @IBOutlet fileprivate weak var colorsCollectionView: UICollectionView!
    fileprivate let minimumSoacing: CGFloat = 15
    fileprivate let itemSize = CGSize(width: 33, height: 33)
    
    ///Presenter
    fileprivate var presenter: AppearancePresenterProtocol {
        return AppearancePresenter()
    }
    
    
    //MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()

        setupColorsCollectionView()
    }
    
    
    //MARK: Private
    private func setupColorItem(indexPath: IndexPath) -> UICollectionViewCell {
        let cell = colorsCollectionView.dequeueReusableCell(withReuseIdentifier: "ColorCell", for: indexPath)
        let cornerRadius = cell.frame.height / 2
        cell.backgroundColor = presenter.setupItemsBackgroundColors(row: indexPath.row)
        cell.contentView.layer.cornerRadius = cornerRadius
        cell.layer.cornerRadius = cornerRadius
        cell.contentView.layer.masksToBounds = true
        
        return cell
    }
    
    private func setupColorsCollectionView() {
        colorsCollectionView.delegate = self
        colorsCollectionView.dataSource = self
        colorsCollectionView.backgroundColor = .systemBackground
    }
}



//MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout extension
extension AppearenceTableViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    internal func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter.setupNumberOfSections()
    }

    internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.setupNumberOfSections()
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return setupColorItem(indexPath: indexPath)
    }
    
    internal func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.saveColor(row: indexPath.row)
    }
    
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return itemSize
    }
    
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumSoacing
    }
    
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumSoacing
    }
}
