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
    }
    
    func setupUI() {
        self.navigationController?.navigationBar.setNavigationBarAppearance()
        channelsTableView.delegate = self
        channelsTableView.dataSource = self
    }
    
    
    
    func fetchData() {
        
        channelsViewModel.getCategories { (categories, errorMessage) in
            if let categories = categories {
                for category in categories {
                    print(category.name as String)
                }
            } else {
                print(errorMessage ?? "Something went wrong")
            }
        }
        
        ///
        
        channelsViewModel.getNewEpisodes { (medias, errorMessage) in
            if let medias = medias {
                for media in medias {
                    print(media.title + ", ")
                }
            } else {
               print(errorMessage ?? "Something went wrong")
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
                print(errorMessage ?? "Something went wrong")
            }
        }
    }
}

extension ChannelsViewController : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewEpisodesTableViewCell", for: indexPath) as? NewEpisodesTableViewCell else { return UITableViewCell() }
        cell.textLabel?.text = "ketan \(indexPath.row)"
        return cell
    }
    
    
}

