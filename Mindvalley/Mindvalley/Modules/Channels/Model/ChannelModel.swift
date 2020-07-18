//
//  ChannelModel.swift
//  Mindvalley
//
//  Created by Admin on 18/07/20.
//  Copyright © 2020 Ketan Parmar. All rights reserved.
//

import Foundation
import SwiftyJSON


struct ChannelModel {
    
    var coverAsset : ChannelCoverAsset!
    var iconAsset : ChannelIconAsset?
    var id : String!
    var latestMedia : [ChannelLatestMedia]!
    var mediaCount : Int!
    var series : [ChannelSeries]!
    var slug : String!
    var title : String!
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        let coverAssetJson = json["coverAsset"]
        if !coverAssetJson.isEmpty{
            coverAsset = ChannelCoverAsset(fromJson: coverAssetJson)
        }
        let iconAssetJson = json["iconAsset"]
        if !iconAssetJson.isEmpty{
            iconAsset = ChannelIconAsset(fromJson: iconAssetJson)
        }
        id = json["id"].stringValue
        latestMedia = [ChannelLatestMedia]()
        let latestMediaArray = json["latestMedia"].arrayValue
        for latestMediaJson in latestMediaArray{
            let value = ChannelLatestMedia(fromJson: latestMediaJson)
            latestMedia.append(value)
        }
        mediaCount = json["mediaCount"].intValue
        series = [ChannelSeries]()
        let seriesArray = json["series"].arrayValue
        for seriesJson in seriesArray{
            let value = ChannelSeries(fromJson: seriesJson)
            series.append(value)
        }
        slug = json["slug"].stringValue
        title = json["title"].stringValue
    }
}

