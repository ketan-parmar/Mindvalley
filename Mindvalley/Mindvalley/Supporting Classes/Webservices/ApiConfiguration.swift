//
//  ApiConfiguration.swift
//  Mindvalley
//
//  Created by Admin on 19/07/20.
//  Copyright © 2020 Ketan Parmar. All rights reserved.
//

import Foundation

/// This will give base URL for API call according to the environment.
class ApiConfiguration: NSObject {
    ///
    static let shared = ApiConfiguration()
    ///
    var baseURL: String = ""
    //
    fileprivate override init() {
         self.buildEnvironment = .development
         super.init()
     }
    
    /// Setup build environment for application.
    var buildEnvironment: DevelopmentEnvironment {
        didSet {
            switch buildEnvironment {
            case .production:
                baseURL = "https://pastebin.com/raw/"
            case .staging:
                baseURL = "https://pastebin.com/raw/"
            case .development:
                baseURL = "https://pastebin.com/raw/"
            default:
                baseURL = "https://pastebin.com/raw/"
            }
        }
    }
}

enum DevelopmentEnvironment: String {
    ///
    case development = "Development"
    ///
    case production = "Production"
    ///
    case local = "Local"
    ///
    case staging = "Staging"
}
