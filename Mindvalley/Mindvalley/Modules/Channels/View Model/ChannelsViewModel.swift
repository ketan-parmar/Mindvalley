//
//  ChannelsViewModel.swift
//  Mindvalley
//
//  Created by Admin on 18/07/20.
//  Copyright © 2020 Ketan Parmar. All rights reserved.
//

import Foundation
import SwiftyJSON

class ChannelsViewModel {
    
    func getCategories(completionHandler: @escaping ([CategoriesModel]?, _ errorMessage: String?) -> Void) {
        
        APIManager.shared.getRequest(url: "https://pastebin.com/raw/A0CgArX3", endPoint: "categories") { (response, error) in
            if let response = response {
                let jsonData = JSON(response)
                guard let array = jsonData["data"]["categories"].array, array.count > 0 else {
                    return
                }
                let arrCateogories = array.map {CategoriesModel(fromJson: $0)}
                completionHandler(arrCateogories, nil)
            } else {
                completionHandler(nil, error?.localizedDescription ?? "Something went wrong!")
            }
        }
        
    }
    
    func getNewEpisodes(completionHandler: @escaping ([MediaModel]?, _ errorMessage: String?) -> Void) {
        
        APIManager.shared.getRequest(url: "https://pastebin.com/raw/z5AExTtw", endPoint: "episodes") { (response, error) in
            if let response = response {
                let jsonData = JSON(response)
                guard let array = jsonData["data"]["media"].array, array.count > 0 else {
                    return
                }
                let arrMedias = array.map {MediaModel(fromJson: $0)}
                completionHandler(arrMedias, nil)
            } else {
                completionHandler(nil ,error?.localizedDescription ?? "Something went wrong!")
            }
        }
    }
    
    
    func getChannels(completionHandler: @escaping ([ChannelModel]?, _ errorMessage: String?) -> Void) {
        
        APIManager.shared.getRequest(url: "https://pastebin.com/raw/Xt12uVhM", endPoint: "channels") { (response, error) in
            
            if let response = response {
                let jsonData = JSON(response)
                guard let array = jsonData["data"]["channels"].array, array.count > 0 else {
                    return
                }
                
                let arrChannels = array.map {ChannelModel(fromJson: $0)}
                
                completionHandler(arrChannels,nil)
            } else {
                completionHandler(nil,error?.localizedDescription ?? "Something went wrong!")
            }
        }
        
    }
}

