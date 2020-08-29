//
//  PlanetsImagesCollectionViewController.swift
//  SolarProject
//
//  Created by Yaroslav Trach on 14.06.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import UIKit

//MARK: - SunImagesTableViewController protocol
protocol PlanetsImagesCollectionViewControllerProtocol {
    func setupCell(cell: PlanetImageCollectionViewCell, indexPath: IndexPath)
    func setupTitle()
}



//MARK: - PlanetsImagesCollectionViewController main class
final class PlanetsImagesCollectionViewController: UICollectionViewController {

    //MARK: Presenter
    var presenter: PlanetsImagesCollectionViewControllerPresenterProtocol {
        return PlanetsImagesCollectionViewControllerPresenter()
    }
    
    //MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTitle()
    }
    
    
    //MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        // #warning Incomplete implementation, return the number of sections
        return presenter.setupNumberOfSections()
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // #warning Incomplete implementation, return the number of items
        return presenter.setupNumberOfItemsInSection()
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlanetImageCell", for: indexPath) as! PlanetImageCollectionViewCell
    
        ///Configure the cell
        setupCell(cell: cell, indexPath: indexPath)
    
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PlanetImageVCSegue" {
            let destVC = segue.destination as! PlanetImageViewController
            let cell = sender as! PlanetImageCollectionViewCell
            
            destVC.image = cell.mainImageView.image!
        }
    }
}



//MARK: - UICollectionViewDelegateFlowLayout extension
extension PlanetsImagesCollectionViewController: UICollectionViewDelegateFlowLayout {
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: CGFloat = 2
        let paddingWidth = 20 * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        let size = CGSize(width: widthPerItem, height: widthPerItem)
        return size
    }
    
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let basicBorder: CGFloat = 20
        return UIEdgeInsets(top: basicBorder, left: basicBorder, bottom: basicBorder, right: basicBorder)
    }
    
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}



//MARK: - PlanetsImagesCollectionViewControllerProtocol extension
extension PlanetsImagesCollectionViewController: PlanetsImagesCollectionViewControllerProtocol {
    internal func setupCell(cell: PlanetImageCollectionViewCell, indexPath: IndexPath) {
        
        ///Setup cell UI
        guard let imageView = cell.mainImageView else { return }
        guard let imageBlurView = cell.imageBlurView else { return }
        guard let imageViewBlackBack = cell.imageViewBlackBack else { return }
        guard let activityIndicator = cell.activityIndicator else { return }
        
        setupImageView(imageView: imageView, indexPath: indexPath)
        setupImageBlurView(imageBlurView: imageBlurView)
        
        ///End animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            activityIndicator.stopAnimating()
            imageBlurView.isHidden = true
        }
        setupImageViewBlackBack(imageViewBlackBack: imageViewBlackBack)
    }
    
    internal func setupTitle() {
        title = "Images"
    }
}



//MARK: Main Methods
extension PlanetsImagesCollectionViewController {
    private func setupImageViewBlackBack(imageViewBlackBack: UIView) {
        imageViewBlackBack.layer.cornerRadius = BasicProperties.cornerRadius + 5
        imageViewBlackBack.layer.masksToBounds = true
    }
    
    private func setupImageBlurView(imageBlurView: UIVisualEffectView) {
        imageBlurView.layer.cornerRadius = BasicProperties.cornerRadius + 5
        imageBlurView.layer.masksToBounds = true
    }
    
    private func setupImageView(imageView: UIImageView, indexPath: IndexPath) {
        imageView.downloaded(from: presenter.setupImagesURLs(row: indexPath.row))
        imageView.layer.cornerRadius = BasicProperties.cornerRadius + 5
        imageView.contentMode = .scaleAspectFill
    }
}
