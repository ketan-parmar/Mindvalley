//
//  MediaModel.swift
//  Mindvalley
//
//  Created by Admin on 18/07/20.
//  Copyright © 2020 Ketan Parmar. All rights reserved.
//

import Foundation
import SwiftyJSON


struct MediaModel {
    
    var channel : MediaChannel!
    var coverAsset : MediaCoverAsset!
    var title : String!
    var type : String!
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        let channelJson = json["channel"]
        if !channelJson.isEmpty{
            channel = MediaChannel(fromJson: channelJson)
        }
        let coverAssetJson = json["coverAsset"]
        if !coverAssetJson.isEmpty{
            coverAsset = MediaCoverAsset(fromJson: coverAssetJson)
        }
        title = json["title"].stringValue
        type = json["type"].stringValue
    }
    
}

