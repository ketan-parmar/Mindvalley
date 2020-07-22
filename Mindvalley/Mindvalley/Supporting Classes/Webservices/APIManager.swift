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
    
    //MARK: - API or Local request
    
    /**If reachability is there then fetchs data from server else from local document directory.
     - Parameters:
     - endPoint: API endpoint
     */
    func getRequest(endPoint: String, completionHandler:@escaping(_ response: [String: Any]?, _ error: Error?) -> Void) {
        
        let fileURL = getFileurl(endPoint: endPoint)
        if NetworkReachabilityManager()?.isReachable ?? false {
            fetchDataFromServer(fileURL: fileURL) { (response, error) in
                completionHandler(response,error)
            }
        } else {
            fetchDataFromDocumentdirectory(fileURL: fileURL) { (response, error) in
                completionHandler(response,error)
            }
        }
    }
    
    
    /// File url of the document directory
    private func getFileurl(endPoint: String) -> URL {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let apiResponsesFolder = documentsURL.appendingPathComponent("API Responses")
        return apiResponsesFolder.appendingPathComponent(endPoint)
    }
    
    /// API Call
    /// Used download request to store response in the document directory to persist it permenantly. Normal request stores data in the cache memory but not persist it permenant.
    private func fetchDataFromServer(fileURL: URL, completionHandler:@escaping(_ response: [String: Any]?, _ error: Error?) -> Void) {
        let destination: DownloadRequest.Destination = { _, _ in
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        let url = ApiConfiguration.shared.baseURL + fileURL.lastPathComponent
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
    }
    
    /// Data from the document direcory
    /// Reachability is not there and response are stored in the document directory then it will be returned
    private func fetchDataFromDocumentdirectory(fileURL: URL, completionHandler:@escaping(_ response: [String: Any]?, _ error: Error?) -> Void) {
        
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

