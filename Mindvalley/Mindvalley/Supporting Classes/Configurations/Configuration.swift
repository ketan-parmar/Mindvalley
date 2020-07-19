//
//  Configuration.swift
//  Mindvalley
//
//  Created by Admin on 19/07/20.
//  Copyright © 2020 Ketan Parmar. All rights reserved.
//

import Foundation

class Configuration {
   
    static let shared = Configuration()
    
    func setInitialConfigurations() {
        
        ApiConfiguration.shared.buildEnvironment = .production
    }
   
}
