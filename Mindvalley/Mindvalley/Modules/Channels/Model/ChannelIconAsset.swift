//
//  ChannelIconAsset.swift
//  Mindvalley
//
//  Created by Admin on 18/07/20.
//  Copyright © 2020 Ketan Parmar. All rights reserved.
//

import Foundation
import SwiftyJSON


struct ChannelIconAsset {
    
    var thumbnailUrl : String!
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        thumbnailUrl = json["thumbnailUrl"].stringValue
    }
    
}

