//
//  ChannelsViewController.swift
//  Mindvalley
//
//  Created by Admin on 18/07/20.
//  Copyright © 2020 Ketan Parmar. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ChannelsViewController: UIViewController {
    
    @IBOutlet weak var channelsTableView: UITableView!
    
    private var channelsViewModel = ChannelsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchData()
    }

    func setupUI() {
        
        self.navigationController?.navigationBar.setNavigationBarAppearance()
        channelsTableView.delegate = self
        channelsTableView.dataSource = self
        channelsTableView.estimatedRowHeight = 1000
        channelsTableView.rowHeight = UITableView.automaticDimension
        
    }
    
    func fetchData() {
        
        channelsViewModel.getCategories { (categories, errorMessage) in
            if let categories = categories {
                for category in categories {
                    print(category.name as String)
                }
            } else {
                print(errorMessage ?? Messages.somethingWentWrong)
            }
        }
        
        ///
        
        channelsViewModel.getNewEpisodes { (medias, errorMessage) in
            if let medias = medias {
                for media in medias {
                    print(media.title + ", ")
                    self.channelsTableView.reloadData()
                }
            } else {
               print(errorMessage ?? Messages.somethingWentWrong)
            }
        }
        
        ///
        
        channelsViewModel.getChannels { (channels, errorMessage) in
            if let channels = channels {
                print("total count = \(channels.count)")
                var counter = 0
                for channel in channels {
                    if let thumbnailUrl = channel.iconAsset?.thumbnailUrl {
                        print(thumbnailUrl + ", ")
                        counter += 1
                    }
                }
                print("icon asset count = \(counter)")
            } else {
                print(errorMessage ?? Messages.somethingWentWrong)
            }
        }
    }
}

extension ChannelsViewController : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 0
        }
     }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewEpisodesTableViewCell", for: indexPath) as? NewEpisodesTableViewCell else { return UITableViewCell() }
      //  cell.textLabel?.text = "ketan \(indexPath.row)"
        cell.configure(medias: channelsViewModel.medias)
        
        return cell
    }
    
}

