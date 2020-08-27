//
//  SunImagesTableViewController.swift
//  SolarProject
//
//  Created by Yaroslav Trach on 13.06.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import UIKit

//MARK: - SunImagesTableViewController main class
final class SunImagesTableViewController: UITableViewController {

    ///Presenter
    fileprivate var presenter: SunImagesPresenterProtocol {
        return SunImagesPresenter()
    }
    
    
    //MARK: Identifiers
    public enum Identifiers: String {
        case segueIdentifier = "PlanetImageVCSegue"
        case cellIdentifier  = "SunImageTableViewCell"
    }
    
    
    
    //MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavController()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Identifiers.segueIdentifier.rawValue {
            let destVC = segue.destination as! PlanetImageViewController
            let cell = sender as! SunImageTableViewCell
            destVC.image = cell.mainImageView.image!
        }
    }

    //MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        /// #warning Incomplete implementation, return the number of sections
        ///Set number Of Sections
        return presenter.numberOfSections()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /// #warning Incomplete implementation, return the number of rows
        ///Set number Of Rows In Section
        return presenter.setupNemberOfRows()
    }

    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return presenter.setupFooter()
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter.setupHeader()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = Identifiers.cellIdentifier.rawValue
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! SunImageTableViewCell

        ///Setup cell
        setupCell(cell: cell, indexPath: indexPath)
        setupSelectionBack(cell: cell)

        return cell
    }
}



//MARK: - SunImagesTableViewControllerProtocol extension
extension SunImagesTableViewController {
    private func setupNavController() {
        title = "Images"
    }
    
    private func setupCell(cell: SunImageTableViewCell, indexPath: IndexPath) {
        guard let imageView = cell.mainImageView else { return }
        guard let imageBlurView = cell.imageBlurView else { return }
        guard let imageViewBlackBack = cell.imageViewBlackBack else { return }
        guard let activityIndicator = cell.activityIndicator else { return }
        
        setupImageView(imageView: imageView, indexPath: indexPath)
        setupImageBlurView(imageBlurView: imageBlurView, indexPath: indexPath)
        setupImageViewBlackBack(imageViewBlackBack: imageViewBlackBack)
        setupPreloadingEnd(activityIndicator: activityIndicator, imageBlurView: imageBlurView)
    }
    
    private func setupImageView(imageView: UIImageView, indexPath: IndexPath) {
        imageView.downloaded(from: MenuContentModel.StarsContent.imagesURLs[indexPath.row])
        imageView.layer.cornerRadius = BasicProperties.cornerRadius + 16
        imageView.contentMode = .scaleAspectFill
    }
    
    private func setupImageBlurView(imageBlurView: UIVisualEffectView, indexPath: IndexPath) {
        imageBlurView.layer.cornerRadius = BasicProperties.cornerRadius + 16
        imageBlurView.layer.masksToBounds = true
        imageBlurView.viewShadows()
        imageBlurView.layer.shadowColor = UIColor.black.cgColor
    }
    
    private func setupImageViewBlackBack(imageViewBlackBack: UIView) {
        imageViewBlackBack.layer.cornerRadius = BasicProperties.cornerRadius + 16
        imageViewBlackBack.viewShadows()
    }
    
    private func setupPreloadingEnd(activityIndicator: UIActivityIndicatorView, imageBlurView: UIVisualEffectView) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            activityIndicator.stopAnimating()
            imageBlurView.isHidden = true
        }
    }
    
    private func setupSelectionBack(cell: SunImageTableViewCell) {
        let bgColorView = UIView()
        bgColorView.backgroundColor = .clear
        cell.selectedBackgroundView = bgColorView
    }
}
