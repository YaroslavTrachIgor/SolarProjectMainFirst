//
//  PersonalAnalyticsTableViewController.swift
//  SolarProject
//
//  Created by Yaroslav Trach on 15.06.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import UIKit
import Charts

//MARK: - MainProfileViewController extension
extension PersonalAnalyticsTableViewController {
    
    //MARK: SectionType enum
    enum SectionType {
        case defaultCells
        case chart
    }
}


//MARK: - PersonalAnalyticsTableViewController main class
final class PersonalAnalyticsTableViewController: UITableViewController {
    
    //MARK: Private, Lazy Properties
    //Presenter
    private var presenter: PersonalAnalyticsTableViewControllerPresenterProtocol {
        return PersonalAnalyticsTableViewControllerPresenter(sections: sections)
    }
    
    //UIRefreshControl
    private lazy var menuRefreshControl: UIRefreshControl = {
        let refreshControl = BasicRefreshControl()
        return refreshControl
    }()
    
    
    ///Sections
    var sections: [SectionType] = [.defaultCells, .chart]
    
    
    //MARK: OverridesChartTableViewCell
    override func viewDidLoad() {
        super.viewDidLoad()

        setupRefreshControl()
        setpTableView()
        setupTitle()
    }

    //MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        /// #warning Incomplete implementation, return the number of sections
        return sections.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter.setupHeadersForSections(section: section)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        /// #warning Incomplete implementation, return the number of rows
        return presenter.setupNumberOfRowsInSection(section: section)
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return presenter.setupFootersForSections(section: section)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        switch section {
        case .defaultCells:
            return setupDefaultCell(tableView: tableView, indexPath: indexPath)
        case .chart:
            return setupChartCell(tableView: tableView, indexPath: indexPath)
        }
    }
}



//MARK: - PersonalAnalyticsTableViewControllerProtocol extension
extension PersonalAnalyticsTableViewController {
    
    //MARK: Setup UI
    private func setupTitle() {
        title = "Pesonal Analytics"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupChartCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChartTableViewCell", for: indexPath) as! ChartTableViewCell
        let dataSet = PieChartDataSet(entries: PersonalAnalyticsModel.shared.chartsItems, label: nil)
        let data = PieChartData(dataSet: dataSet)
        let colors = presenter.setupChartColors()
        
        dataSet.colors = colors
        cell.chartView.data = data
        cell.chartView.chartDescription?.text = ""
        tableView.rowHeight = 300
        
        return cell
    }
    
    private func setupDefaultCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonalAnalyticsTableViewCell", for: indexPath) as! PersonalAnalyticsTableViewCell
        
        setupContent(cell: cell, indexPath: indexPath)
        setupViewsCountBackView(cell: cell, indexPath: indexPath)
        setupTitleLabel(titleLabel: cell.titleLabel)
        setupSubtitleLabel(subtitleLabel: cell.subtitleLabel)
        setupArrowImage(cell: cell)
        tableView.rowHeight = 60
        
        return cell
    }
    
    private func setpTableView() {
        tableView.backgroundColor = .systemGroupedBackground
        tableView.separatorColor = #colorLiteral(red: 0.962546849, green: 0.962546849, blue: 0.962546849, alpha: 1)
    }
    
    private func setupRefreshControl() {
        tableView.refreshControl = menuRefreshControl
        menuRefreshControl.addTarget(self, action: #selector(setupRefreshControlAction), for: .valueChanged)
    }

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
                setupBasicViewsCountBackView(cell: cell, textColor: #colorLiteral(red: 0.8708954632, green: 0.008538190816, blue: 0.008538190816, alpha: 1), backgroundColor: #colorLiteral(red: 1, green: 0.4768956451, blue: 0.451322693, alpha: 1), imageName: "arrow.down")
            }
        }, green: {
            if PersonalAnalyticsModel.shared.views[indexPath.row] == 0 {
                setupZeroCountViewType()
            } else {
                setupBasicViewsCountBackView(cell: cell, textColor: #colorLiteral(red: 0.02897588643, green: 0.9019670051, blue: 3.004153609e-16, alpha: 1), backgroundColor: #colorLiteral(red: 0.5731121365, green: 1, blue: 0.6017802306, alpha: 1), imageName: "arrow.up")
            }
        }, normal: {
            if PersonalAnalyticsModel.shared.views[indexPath.row] == 0 {
                setupZeroCountViewType()
            } else {
                setupBasicViewsCountBackView(cell: cell, textColor: BasicProperties.color, backgroundColor: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 0.2718987026), imageName: "")
            }
        }, zero: {
            setupZeroCountViewType()
            
        }, indexPath: indexPath)
    
        cell.viewsCountBackView.viewShadows()
        cell.viewsCountBackView.layer.shadowRadius = 5
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
        titleLabel.textColor = .black
        titleLabel.backgroundColor = .clear
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    }
    
    private func setupSubtitleLabel(subtitleLabel: UILabel) {
        subtitleLabel.textColor = .lightGray
        subtitleLabel.backgroundColor = .clear
        subtitleLabel.font = UIFont.systemFont(ofSize: 9.5, weight: .regular)
    }
    
    private func setupArrowImage(cell: PersonalAnalyticsTableViewCell) {
        cell.arrowImage.tintColor = cell.viewsCountLabel.textColor!
    }
    
    
    //MARK: @objc
    @objc func setupRefreshControlAction() {
        tableView.reloadData()
    }
}
