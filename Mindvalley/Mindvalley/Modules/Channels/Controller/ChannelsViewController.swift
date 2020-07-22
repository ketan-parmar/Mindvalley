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
import SDWebImage

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
        
        channelsTableView.register(UINib(nibName: "CategoriesHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoriesHeaderTableViewCell")
        channelsTableView.register(UINib(nibName: "CategoriesTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoriesTableViewCell")
        channelsTableView.register(UINib(nibName: "CourseTableViewCell", bundle: nil), forCellReuseIdentifier: "CourseTableViewCell")
        channelsTableView.register(UINib(nibName: "SeriesTableViewCell", bundle: nil), forCellReuseIdentifier: "SeriesTableViewCell")
        
        
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
                self.channelsTableView.reloadData()
            } else {
                print(errorMessage ?? Messages.somethingWentWrong)
            }
        }
        
        ///
        
        channelsViewModel.getNewEpisodes { (medias, errorMessage) in
            if let medias = medias {
                for media in medias {
                    print(media.title + ", ")
                }
                self.channelsTableView.reloadData()
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
                self.channelsTableView.reloadData()
                print("icon asset count = \(counter)")
            } else {
                print(errorMessage ?? Messages.somethingWentWrong)
            }
        }
    }
}

extension ChannelsViewController : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return channelsViewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1{
            return channelsViewModel.channels.count
        } else {
            return channelsViewModel.categories.count > 0 ? channelsViewModel.categories.count + 1 : 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewEpisodesTableViewCell", for: indexPath) as? NewEpisodesTableViewCell else { return UITableViewCell() }
            cell.configure(medias: channelsViewModel.medias)
            
            return cell
        } else if indexPath.section == 1 {
            
            let channel = channelsViewModel.channels[indexPath.row]
            
            if channel.series.count > 0 {
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "SeriesTableViewCell", for: indexPath) as? SeriesTableViewCell else { return UITableViewCell() }
                if let thumbnailUrl = channel.iconAsset?.thumbnailUrl {
                    cell.seriesIconImageView.sd_setImage(with: URL(string: thumbnailUrl), completed: nil)
                } else {
                    cell.seriesIconImageView.image = nil
                }
                cell.seriesTitle.text = channel.title
                cell.seriesEpisodesCount.text = "\(channel.mediaCount ?? 0) series"
                cell.configure(series: channel.series)
                
                return cell
                
                
            } else {
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "CourseTableViewCell", for: indexPath) as? CourseTableViewCell else { return UITableViewCell() }
                
                if let thumbnailUrl = channel.iconAsset?.thumbnailUrl {
                    cell.courseIconImageView.sd_setImage(with: URL(string: thumbnailUrl), completed: nil)
                } else {
                    cell.courseIconImageView.image = nil
                }
                cell.courseTitle.text = channel.title
                cell.courseEpisodesCount.text = "\(channel.mediaCount ?? 0) episodes"
                cell.configure(course: channel.latestMedia)
                
                return cell
            }
            
        } else {
            
            if indexPath.row == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesHeaderTableViewCell", for: indexPath) as? CategoriesHeaderTableViewCell else { return UITableViewCell() }
                
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesTableViewCell", for: indexPath) as? CategoriesTableViewCell else { return UITableViewCell() }
                cell.configure(category: channelsViewModel.categories[indexPath.row - 1])
                return cell
            }
        }
        
    }
    
}

