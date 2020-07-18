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
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var tempLabel2: UILabel!
    @IBOutlet weak var tempLabel3: UILabel!
    private var channelsViewModel = ChannelsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tempLabel.text = ""
        tempLabel2.text = ""
        tempLabel3.text = ""
        
        channelsViewModel.getCategories { (categories, errorMessage) in
            if let categories = categories {
                for category in categories {
                    print(category.name as String)
                    self.tempLabel.text! += category.name + ", "
                }
            } else {
                self.tempLabel.text = errorMessage
            }
        }
        
        ///
        
        channelsViewModel.getNewEpisodes { (medias, errorMessage) in
            if let medias = medias {
                for media in medias {
                    self.tempLabel2.text! += media.title + ", "
                }
            } else {
                self.tempLabel2.text = errorMessage
            }
        }
        
        ///
        
        channelsViewModel.getChannels { (channels, errorMessage) in
            if let channels = channels {
                print("total count = \(channels.count)")
                var counter = 0
                for channel in channels {
                    if let thumbnailUrl = channel.iconAsset?.thumbnailUrl {
                        self.tempLabel3.text! += thumbnailUrl + ", "
                        counter += 1
                    }
                }
                print("icon asset count = \(counter)")
            } else {
                self.tempLabel3.text = errorMessage
            }
        }
        
    }
}


