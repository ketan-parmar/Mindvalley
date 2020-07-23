//
//  MindvalleyTests.swift
//  MindvalleyTests
//
//  Created by Admin on 23/07/20.
//  Copyright © 2020 Ketan Parmar. All rights reserved.
//

import XCTest
@testable import Mindvalley
@testable import SwiftyJSON

class MindvalleyTests: XCTestCase {
    
    //MARK: - Variables
    
    ///Episode
    let expectedEpisodeTitle = "Conscious Parenting"
    let expectedEpisodeChannelTitle = "Little Humans"
    let expectedEpisodeCoverAssetUrl = "https://assets.mindvalley.com/api/v1/assets/5bdbdd0e-3bd3-432b-b8cb-3d3556c58c94.jpg?transform=w_1080"
    var episode: EpisodeModel!
    
    ///Channel
    let expectedChannelTitle = "Mindvalley Mentoring"
    let expectedChannelMediaCount = 98
    let expectedChannelSeriesCount = 0
    let expectedChannelLatestMediasCount = 12
    var channel: ChannelModel!
    
    ///Category
    let expectedCategoryName = "Career"
    var category: CategoriesModel!
    var categoryArr: [CategoriesModel]!
    
    ///View Model
    var channelViewModel : ChannelsViewModel!
    
    //MARK: - Setup
    override func setUp() {
        super.setUp()
        
        setupEpisodeModel()
        setupCategoryModel()
        setupChannelModel()
        
        channelViewModel = ChannelsViewModel()
    }
    
    override func tearDown() {
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    ///Episode model setup
    private func setupEpisodeModel() {
        let bundle = Bundle(for: self.classForCoder)
        let episodeURL = bundle.url(forResource: "Episodes", withExtension: nil)
        guard let data = FileManager.default.contents(atPath: episodeURL!.path) else {
            return
        }
        do {
            if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] {
                let jsonData = JSON(jsonObject)
                guard let array = jsonData[Keys.data][Keys.media].array, array.count > 0 else {
                    return
                }
                let arrEpisodes = array.map {EpisodeModel(fromJson: $0)}
                episode = arrEpisodes[0]
            } else {
                print("Error to parse data of episode model")
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    ///Channel model setup
    private func setupChannelModel() {
        let bundle = Bundle(for: self.classForCoder)
        let episodeURL = bundle.url(forResource: "Channels", withExtension: nil)
        guard let data = FileManager.default.contents(atPath: episodeURL!.path) else {
            return
        }
        do {
            if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] {
                let jsonData = JSON(jsonObject)
                guard let array = jsonData[Keys.data][Keys.channels].array, array.count > 0 else {
                    return
                }
                let arrChannels = array.map {ChannelModel(fromJson: $0)}
                channel = arrChannels[0]
            } else {
                print("Error to parse data of channel model")
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    ///Category model setup
    private func setupCategoryModel() {
        
        let bundle = Bundle(for: self.classForCoder)
        let episodeURL = bundle.url(forResource: "Categories", withExtension: nil)
        guard let data = FileManager.default.contents(atPath: episodeURL!.path) else {
            return
        }
        do {
            if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] {
                let jsonData = JSON(jsonObject)
                guard let array = jsonData[Keys.data][Keys.categories].array, array.count > 0 else {
                    return
                }
                let arrCategories = array.map {CategoriesModel(fromJson: $0)}
                categoryArr = arrCategories
                category = arrCategories[0]
            } else {
                print("Error to parse data of category model")
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    //MARK: - Model Class Tests
    
    ///Test Episode model
    private func testEpisodeModel() {
        XCTAssertEqual(episode.title, expectedEpisodeTitle)
        XCTAssertEqual(episode.channel.title, expectedEpisodeChannelTitle)
        XCTAssertEqual(episode.coverAsset.url, expectedEpisodeCoverAssetUrl)
        //        measure {
        //            // Put the code you want to measure the time of here.
        //        }
    }
    
    ///Test Channel model
    private func testChannelModel() {
        XCTAssertEqual(channel.title, expectedChannelTitle)
        XCTAssertEqual(channel.mediaCount, expectedChannelMediaCount)
        XCTAssertNotNil(channel.series)
        XCTAssertNotNil(channel.latestMedia)
        XCTAssertEqual(channel.series.count, expectedChannelSeriesCount)
        XCTAssertEqual(channel.latestMedia.count, expectedChannelLatestMediasCount)
    }
    
    ///Test Category model
    private func testCategoryModel() {
        XCTAssertEqual(category.name, expectedCategoryName)
    }
    
    //MARK: - Channel View Model Test
    
    /// Test fetchdata method
    private func testFetchDataMethod() {
        
        let promise = expectation(description: "all api calls")
        channelViewModel.fetchData {
            promise.fulfill()
        }
        wait(for: [promise], timeout: 5.0)
        XCTAssertEqual(self.channelViewModel.numberOfSections, 3)
    }
    
    ///Test setCategories method
    private func testSetCategoryMethod() {
        channelViewModel.setCategories(categoryArr: categoryArr)
        XCTAssertEqual(channelViewModel.categories.count, 6)
    }
    
    ///Test increaseSectionByOne method
    private func testIncreaseSectionByOneMethod() {
        let numberOfSections = channelViewModel.numberOfSections
        channelViewModel.increaseSectionByOne()
        XCTAssertEqual(channelViewModel.numberOfSections, numberOfSections + 1)
    }
    
    //MARK: - Supporting Classes Test
    
    ///Test setInitialConfigurations method of Configuration class
    private func testsetInitialConfigurationsMethod() {
        Configuration.shared.setInitialConfigurations()
        XCTAssertEqual(ApiConfiguration.shared.buildEnvironment, DevelopmentEnvironment.production)
    }
    
    ///Test color code to UIColor conversion of Extensions file
    private func testColorCodeConversation() {
        let whiteColorCode = 0xffffff
        let whiteColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        XCTAssertEqual(UIColor(rgb: whiteColorCode), whiteColor)
    }
    
    ///Test array to chunked array conversion of Extensions file
    private func testArrayChunkedConversion() {
        let arr = [1,2,3,4,5,6]
        let resultArr = [[1,2],[3,4],[5,6]]
        XCTAssertEqual(arr.chunked(into: 2), resultArr)
    }
    
}

