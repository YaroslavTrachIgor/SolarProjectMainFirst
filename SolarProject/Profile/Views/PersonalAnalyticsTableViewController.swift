//
//  PersonalAnalyticsTableViewController.swift
//  SolarProject
//
//  Created by Yaroslav Trach on 15.06.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import UIKit
import Charts

//MARK: - PersonalAnalyticsTableViewControllerProtocol protocol
protocol PersonalAnalyticsTableViewControllerProtocol {
    func setupRefreshControl()
    func setpSeparator()
    func setupCell(cell: PersonalAnalyticsTableViewCell, indexPath: IndexPath)
    func setupTitle()
}



//MARK: - PersonalAnalyticsTableViewController main class
final class PersonalAnalyticsTableViewController: UITableViewController {
    
    //MARK: Private, Lazy Properties
    //Presenter
    private var presenter: PersonalAnalyticsTableViewControllerPresenter {
        return PersonalAnalyticsTableViewControllerPresenter()
    }
    
    //UIRefreshControl
    private lazy var menuRefreshControl: UIRefreshControl = {
        let refreshControl = BasicRefreshControl()
        return refreshControl
    }()
    
    
    //MARK: OverridesChartTableViewCell
    override func viewDidLoad() {
        super.viewDidLoad()

        setupRefreshControl()
        setpSeparator()
        setupTitle()
    }

    //MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        /// #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter.setupHeadersForSections(section: section)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        /// #warning Incomplete implementation, return the number of rows
        return presenter.setupNumberOfRowsInSection(section: section)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PersonalAnalyticsTableViewCell", for: indexPath) as! PersonalAnalyticsTableViewCell
            
            //MARK: Configure Basic cell
            setupCell(cell: cell, indexPath: indexPath)
            
            return cell
        } else {
            
            //MARK: Configure Chart cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChartTableViewCell", for: indexPath) as! ChartTableViewCell
            
            let dataSet = PieChartDataSet(entries: PersonalAnalyticsModel.shared.chartsItems, label: nil)
            let data = PieChartData(dataSet: dataSet)
            let colors = presenter.setupChartColors()
            
            dataSet.colors = colors
            cell.chartView.data = data
            cell.chartView.chartDescription?.text = ""
            
            ///Set tableView rowHeight for section 0
            tableView.rowHeight = 300
            
            return cell
        }
    }
}



//MARK: - PersonalAnalyticsTableViewControllerProtocol extension
extension PersonalAnalyticsTableViewController: PersonalAnalyticsTableViewControllerProtocol {
    
    //MARK: Setup UI
    internal func setupTitle() {
        title = "Pesonal Analytics"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    internal func setpSeparator() {
        tableView.separatorColor = #colorLiteral(red: 0.962546849, green: 0.962546849, blue: 0.962546849, alpha: 1)
    }
    
    internal func setupRefreshControl() {
        tableView.refreshControl = menuRefreshControl
        menuRefreshControl.addTarget(self, action: #selector(setupRefreshControlAction), for: .valueChanged)
    }
    
    
    internal func setupCell(cell: PersonalAnalyticsTableViewCell, indexPath: IndexPath) {
        
        ///Setup content
        setupContent(cell: cell, indexPath: indexPath)
        
        ///Setup ViewsCountBackView
        setupViewsCountBackView(cell: cell, indexPath: indexPath)
        
        ///Setup titleLabel
        setupTitleLabel(titleLabel: cell.titleLabel)
        
        ///Setup subtitleLabel
        setupSubtitleLabel(subtitleLabel: cell.subtitleLabel)
        
        ///Setup arrowImage
        setupArrowImage(cell: cell)
        
        ///Set tableView rowHeight for section 1
        tableView.rowHeight = 75
    }
    
    
    //MARK: @objc
    @objc func setupRefreshControlAction() {
        
        ///Setup fast tableView data reload
        tableView.reloadData()
    }
    
    
    //MARK: Private
    private func setupStatusBarView(with size: CGFloat) {
        let statusBarView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: size))
        statusBarView.backgroundColor = .black
        navigationController?.view.addSubview(statusBarView)
    }
    
    private func setupContent(cell: PersonalAnalyticsTableViewCell, indexPath: IndexPath) {
        cell.titleLabel.text = presenter.setupTitleLabelsContent(indexPath: indexPath)
        cell.subtitleLabel.text = presenter.setupSubTitleLabelsContent(indexPath: indexPath)
        cell.viewsCountLabel.text = presenter.setupViews(indexPath: indexPath)
    }
    
    private func setupViewsCountBackView(cell: PersonalAnalyticsTableViewCell, indexPath: IndexPath) {
        presenter.setupCell(
        red: {
            if PersonalAnalyticsModel.shared.views[indexPath.row] == 0 {
                setupZeroCountViewType()
            } else {
                
                ///Setup First CountView type
                setupBasicViewsCountBackView(cell: cell, textColor: #colorLiteral(red: 0.8708954632, green: 0.008538190816, blue: 0.008538190816, alpha: 1), backgroundColor: #colorLiteral(red: 1, green: 0.4768956451, blue: 0.451322693, alpha: 1), imageName: "arrow.down")
            }
        }, green: {
            if PersonalAnalyticsModel.shared.views[indexPath.row] == 0 {
                setupZeroCountViewType()
            } else {
                
                ///Setup Third CountView type
                setupBasicViewsCountBackView(cell: cell, textColor: #colorLiteral(red: 0.02897588643, green: 0.9019670051, blue: 3.004153609e-16, alpha: 1), backgroundColor: #colorLiteral(red: 0.5731121365, green: 1, blue: 0.6017802306, alpha: 1), imageName: "arrow.up")
            }
        }, normal: {
            if PersonalAnalyticsModel.shared.views[indexPath.row] == 0 {
                setupZeroCountViewType()
            } else {
                
                ///Setup Second CountView type
                setupBasicViewsCountBackView(cell: cell, textColor: BasicProperties.color, backgroundColor: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 0.2718987026), imageName: "")
            }
        }, zero: {
            setupZeroCountViewType()
            
        }, indexPath: indexPath)
    
        cell.viewsCountBackView.viewShadows()
        cell.viewsCountBackView.layer.shadowColor = cell.viewsCountBackView.backgroundColor!.cgColor
        cell.viewsCountBackView.layer.cornerRadius = BasicProperties.cornerRadius
        
        
        ///ZeroCountViewType method
        func setupZeroCountViewType() {
            setupBasicViewsCountBackView(cell: cell, textColor: .black, backgroundColor: .systemGroupedBackground, imageName: "")
        }
    }
    
    private func setupBasicViewsCountBackView(cell: PersonalAnalyticsTableViewCell, textColor: UIColor, backgroundColor: UIColor, imageName: String) {
        cell.viewsCountBackView.backgroundColor = backgroundColor
        cell.viewsCountLabel.textColor = textColor
        cell.arrowImage.image = UIImage(systemName: imageName)
    }
    
    private func setupTitleLabel(titleLabel: UILabel) {
        titleLabel.labelShadow()
    }
    
    private func setupSubtitleLabel(subtitleLabel: UILabel) {
        subtitleLabel.labelShadow()
        subtitleLabel.layer.shadowColor = subtitleLabel.textColor!.cgColor
    }
    
    private func setupArrowImage(cell: PersonalAnalyticsTableViewCell) {
        cell.arrowImage.tintColor = cell.viewsCountLabel.textColor!
    }
}
