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
    
    var medias : [MediaModel] = []
    var categories : [[CategoriesModel]] = []
    var channels : [ChannelModel] = []
    var numberOfSections = 0
    
    
    func getCategories(completionHandler: @escaping ([CategoriesModel]?, _ errorMessage: String?) -> Void) {
        
        APIManager.shared.getRequest(endPoint: ApiList.categories) { (response, error) in
            if let response = response {
                let jsonData = JSON(response)
                guard let array = jsonData[Keys.data][Keys.categories].array, array.count > 0 else {
                    return
                }
                let arrCateogories = array.map {CategoriesModel(fromJson: $0)}
                if arrCateogories.count > 0 {
                    self.increaseSectionByOne()
                }
                self.setCategories(categoryArr: arrCateogories)
                completionHandler(arrCateogories, nil)
            } else {
                completionHandler(nil, error?.localizedDescription ?? Messages.somethingWentWrong)
            }
        }
        
    }
    
    func getNewEpisodes(completionHandler: @escaping ([MediaModel]?, _ errorMessage: String?) -> Void) {
        
        APIManager.shared.getRequest(endPoint: ApiList.episodes) { (response, error) in
            if let response = response {
                let jsonData = JSON(response)
                guard let array = jsonData[Keys.data][Keys.media].array, array.count > 0 else {
                    return
                }
                let arrMedias = array.map {MediaModel(fromJson: $0)}
                if arrMedias.count > 0 {
                    self.increaseSectionByOne()
                }
                self.medias = arrMedias
                completionHandler(arrMedias, nil)
            } else {
                completionHandler(nil ,error?.localizedDescription ?? Messages.somethingWentWrong)
            }
        }
    }
    
    
    func getChannels(completionHandler: @escaping ([ChannelModel]?, _ errorMessage: String?) -> Void) {
        
        APIManager.shared.getRequest(endPoint: ApiList.channels) { (response, error) in
            if let response = response {
                let jsonData = JSON(response)
                guard let array = jsonData[Keys.data][Keys.channels].array, array.count > 0 else {
                    return
                }
                
                let arrChannels = array.map {ChannelModel(fromJson: $0)}
                if arrChannels.count > 0 {
                    self.increaseSectionByOne()
                }
                self.channels = arrChannels
                completionHandler(arrChannels,nil)
            } else {
                completionHandler(nil,error?.localizedDescription ?? Messages.somethingWentWrong)
            }
        }
        
    }
    
    func setCategories(categoryArr: [CategoriesModel]) {
        categories = categoryArr.chunked(into: 2)
    }
    
    func increaseSectionByOne() {
        numberOfSections += 1
    }
}

