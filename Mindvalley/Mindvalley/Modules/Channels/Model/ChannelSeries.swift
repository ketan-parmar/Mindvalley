//
//  ChannelSeries.swift
//  Mindvalley
//
//  Created by Admin on 18/07/20.
//  Copyright © 2020 Ketan Parmar. All rights reserved.
//

import Foundation
import SwiftyJSON


struct ChannelSeries {
    
    var coverAsset : ChannelCoverAsset!
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
        title = json["title"].stringValue
    }
}

