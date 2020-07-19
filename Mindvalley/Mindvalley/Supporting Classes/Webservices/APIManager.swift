//
//  APIManager.swift
//  Mindvalley
//
//  Created by Admin on 18/07/20.
//  Copyright © 2020 Ketan Parmar. All rights reserved.
//

import Foundation
import Alamofire

class APIManager {
    
    static let shared = APIManager()
    
    func getRequest(endPoint: String, completionHandler:@escaping(_ response: [String: Any]?, _ error: Error?) -> Void) {
        
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let apiResponsesFolder = documentsURL.appendingPathComponent("API Responses")
        let fileURL = apiResponsesFolder.appendingPathComponent(endPoint)
        
        if NetworkReachabilityManager()?.isReachable ?? false {
            
            let destination: DownloadRequest.Destination = { _, _ in
                return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
            }
            let url = ApiConfiguration.shared.baseURL + endPoint
            
            let request = AF.download(url, interceptor: nil, to: destination)
            request.responseJSON { (response) in
                
                switch response.result {
                    
                case .success(let data):
                    
                    if let responseJson = data as? [String : Any] {
                        completionHandler(responseJson, nil)
                    } else {
                        completionHandler(nil, response.error)
                    }
                    
                case .failure(let error as Error):
                    completionHandler(nil, error)
                }
                
            }
            
        } else {
            
            if FileManager.default.fileExists(atPath: fileURL.path) {
                
                guard let data = FileManager.default.contents(atPath: fileURL.path) else {
                    return
                }
                do {
                    if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] {
                        completionHandler(jsonObject, nil)
                    } else {
                        completionHandler(nil, Error.self as? Error)
                    }
                } catch let error {
                    completionHandler(nil, error)
                }
                
            } else {
                
                completionHandler(nil, Error.self as? Error)
                
            }
        }
    }
}

