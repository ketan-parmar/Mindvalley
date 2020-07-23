//
//  ChannelsViewModel.swift
//  Mindvalley
//
//  Created by Admin on 18/07/20.
//  Copyright © 2020 Ketan Parmar. All rights reserved.
//

import Foundation
import SwiftyJSON
import SDWebImage

class ChannelsViewModel {
    
    //MARK: - Variables
    var episodes : [EpisodeModel] = []
    var categories : [[CategoriesModel]] = []
    var channels : [ChannelModel] = []
    var numberOfSections = 0
    var storedOffsets = [Int: CGFloat]()
    
}

//MARK: - Tableview
extension ChannelsViewModel {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSections == 3 ? 3 : 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1{
            return channels.count
        } else {
            return categories.count > 0 ? categories.count + 1 : 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.newEpisodesTableViewCell, for: indexPath) as? NewEpisodesTableViewCell else { return UITableViewCell() }
            cell.configure(episodes: episodes)
            
            return cell
        } else if indexPath.section == 1 {
            
            let channel = channels[indexPath.row]
            
            if channel.series.count > 0 {
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.seriesTableViewCell, for: indexPath) as? SeriesTableViewCell else { return UITableViewCell() }
                if let thumbnailUrl = channel.iconAsset?.thumbnailUrl {
                    cell.seriesIconImageView.sd_setImage(with: URL(string: thumbnailUrl), completed: nil)
                } else {
                    cell.seriesIconImageView.image = nil
                }
                cell.seriesTitle.text = channel.title
                cell.seriesEpisodesCount.text = "\(channel.mediaCount ?? 0) \(Keys.series)"
                cell.configure(series: channel.series, offset: storedOffsets[indexPath.row] ?? 0)
                
                return cell
                
            } else {
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.courseTableViewCell, for: indexPath) as? CourseTableViewCell else { return UITableViewCell() }
                
                if let thumbnailUrl = channel.iconAsset?.thumbnailUrl {
                    cell.courseIconImageView.sd_setImage(with: URL(string: thumbnailUrl), completed: nil)
                } else {
                    cell.courseIconImageView.image = nil
                }
                cell.courseTitle.text = channel.title
                cell.courseEpisodesCount.text = "\(channel.mediaCount ?? 0) \(Keys.episodes)"
                cell.configure(course: channel.latestMedia, offset: storedOffsets[indexPath.row] ?? 0)
                
                return cell
            }
            
        } else {
            
            if indexPath.row == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.categoriesHeaderTableViewCell, for: indexPath) as? CategoriesHeaderTableViewCell else { return UITableViewCell() }
                
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.categoriesTableViewCell, for: indexPath) as? CategoriesTableViewCell else { return UITableViewCell() }
                cell.configure(category: categories[indexPath.row - 1])
                
                return cell
            }
        }
    }
    
    /// Storing last offset of the collectionview to save the scroll position
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.section == 1 {
            
            let channel = channels[indexPath.row]
            if channel.series.count > 0 {
                
                guard let cell = cell as? SeriesTableViewCell else { return }
                storedOffsets[indexPath.row] =  cell.collectionViewOffset
                
            } else {
                
                guard let cell = cell as? CourseTableViewCell else { return }
                storedOffsets[indexPath.row] = cell.collectionViewOffset
            }
        }
    }
    
}

//MARK: - Functions
extension ChannelsViewModel {
    
    func setCategories(categoryArr: [CategoriesModel]) {
        categories = categoryArr.chunked(into: 2)
    }
    func increaseSectionByOne() {
        numberOfSections += 1
    }
}

//MARK: - APIs
extension ChannelsViewModel {
    
    func fetchData(completionHandler: @escaping () -> Void) {
        let dispatchGroup = DispatchGroup()
        ///
        dispatchGroup.enter()
        getNewEpisodes { (medias, errorMessage) in
            dispatchGroup.leave()
        }
        ///
        dispatchGroup.enter()
        getCategories { (categories, errorMessage) in
            dispatchGroup.leave()
        }
        ///
        dispatchGroup.enter()
        getChannels { (channels, errorMessage) in
            dispatchGroup.leave()
        }
        ///
        dispatchGroup.notify(queue: .main) {
            completionHandler()
        }
        
    }
    
    private func getCategories(completionHandler: @escaping ([CategoriesModel]?, _ errorMessage: String?) -> Void) {
        
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
    
    private func getNewEpisodes(completionHandler: @escaping ([EpisodeModel]?, _ errorMessage: String?) -> Void) {
        
        APIManager.shared.getRequest(endPoint: ApiList.episodes) { (response, error) in
            if let response = response {
                let jsonData = JSON(response)
                guard let array = jsonData[Keys.data][Keys.media].array, array.count > 0 else {
                    return
                }
                let arrEpisodes = array.map {EpisodeModel(fromJson: $0)}
                if arrEpisodes.count > 0 {
                    self.increaseSectionByOne()
                }
                self.episodes = arrEpisodes
                completionHandler(arrEpisodes, nil)
            } else {
                completionHandler(nil ,error?.localizedDescription ?? Messages.somethingWentWrong)
            }
        }
    }
    
    
    private func getChannels(completionHandler: @escaping ([ChannelModel]?, _ errorMessage: String?) -> Void) {
        
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
}
