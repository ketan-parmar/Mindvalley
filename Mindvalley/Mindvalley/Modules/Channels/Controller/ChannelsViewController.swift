//
//  ChannelsViewController.swift
//  Mindvalley
//
//  Created by Admin on 18/07/20.
//  Copyright © 2020 Ketan Parmar. All rights reserved.
//

import UIKit

class ChannelsViewController: UIViewController {
    
    //MARK: - Outlets and Variables
    @IBOutlet weak var channelsTableView: UITableView!
    private var channelsViewModel = ChannelsViewModel()
    
    //MARK: - View controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchData()
    }
    
    //MARK: - UI and APIs
    func setupUI() {
        
        self.navigationController?.navigationBar.setNavigationBarAppearance()
        
        channelsTableView.register(UINib(nibName: Identifiers.newEpisodesTableViewCell, bundle: nil), forCellReuseIdentifier: Identifiers.newEpisodesTableViewCell)
        
        channelsTableView.register(UINib(nibName: Identifiers.categoriesHeaderTableViewCell, bundle: nil), forCellReuseIdentifier: Identifiers.categoriesHeaderTableViewCell)
        
        channelsTableView.register(UINib(nibName: Identifiers.categoriesTableViewCell, bundle: nil), forCellReuseIdentifier: Identifiers.categoriesTableViewCell)
        
        channelsTableView.register(UINib(nibName: Identifiers.courseTableViewCell, bundle: nil), forCellReuseIdentifier: Identifiers.courseTableViewCell)
        
        channelsTableView.register(UINib(nibName: Identifiers.seriesTableViewCell, bundle: nil), forCellReuseIdentifier: Identifiers.seriesTableViewCell)
        
        channelsTableView.delegate = self
        channelsTableView.dataSource = self
        channelsTableView.estimatedRowHeight = 1000
        channelsTableView.rowHeight = UITableView.automaticDimension
        
    }
    
    func fetchData() {
        
        channelsViewModel.fetchData {
            self.channelsTableView.reloadData()
            print("table reloaded")
        }

    }
}

//MARK: - Tableview Delegate and Datasource
extension ChannelsViewController : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return channelsViewModel.numberOfSections(in: tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channelsViewModel.tableView(tableView, numberOfRowsInSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return channelsViewModel.tableView(tableView, cellForRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        channelsViewModel.tableView(tableView, didEndDisplaying: cell, forRowAt: indexPath)
    }
}

