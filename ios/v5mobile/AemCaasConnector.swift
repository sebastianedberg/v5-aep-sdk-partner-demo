//
//  CaasViewController.swift
//  v5mobile
//
//  Created by max on 2018-10-05.
//  Copyright © 2018 max. All rights reserved.
//

import Foundation

struct CaasLocation {
    let coordinates: (latitude: Double, longitude: Double)
    let title: String
    let thumbnailUrl: String
}

enum SerializationError: Error {
    case missing(String)
    case invalid(String, Any)
}
/**
 * @brief Send ACPCore.trackAction or ACPCore.trackState
 */
extension CaasLocation {
    /**
     * @brief call AEM CaaS endpoint
     * @param url String AEM CaaS endpoint
     * @return locations CaasLocation A array of locations
     */
    static func callAemCaasService(with url: String, completion: @escaping ([CaasLocation]) -> Void) {
        
        var config                              :URLSessionConfiguration!
        var urlSession                          :URLSession!
        
        config = URLSessionConfiguration.default
        urlSession = URLSession(configuration: config)
        
        let HTTPHeaderField_ContentType         = "Content-Type"
        let ContentType_ApplicationJson         = "application/json"
        let HTTPMethod_Get                      = "GET"
 
        let callURL = URL.init(string: url)
        var request = URLRequest.init(url: callURL!)
        
        request.timeoutInterval = 60.0 // TimeoutInterval in Second
        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
        request.addValue(ContentType_ApplicationJson, forHTTPHeaderField: HTTPHeaderField_ContentType)
        request.httpMethod = HTTPMethod_Get
        
        var locations: [CaasLocation] = []
        
        let dataTask = urlSession.dataTask(with: request) { (data,response,error) in
            if error != nil{
                return
            }
            do {
                let json = try JSON(data: data!)
                Logger.getInstance().log(json.rawString() ?? "no json response")
                /**
                 * @info The selector and iterator here is specific to the default structure of how AEM exposed the content as JSON.
                            If you make any changes to the API please adjust it here as well.
                 */
                let keys:[JSONSubscriptType] = [":items","root",":items","responsivegrid",":items"]
                let items = json[keys]
                
                for (_, subJson):(String, JSON) in items {
                    if subJson["elements"].exists() {
                        if let loc = try CaasLocation(json: subJson["elements"]) {
                            Logger.getInstance().log("CaasLocation: \(loc)")
                            locations.append(loc)
                        }
                    }
                }
            } catch {
                Logger.getInstance().log("Error -> \(error)")
            }
            completion(locations)
        }
        dataTask.resume()
    }
    /**
     * @brief Struct for exptected AEM Content Fragment Model
     * @note If you add additional fields in AEM you have to update it here as well.
     A more dynamic approach would be nice in the future ;)
     */
    init?(json: JSON) throws {
        
        guard let title = json["title"]["value"].string  else {
            throw SerializationError.missing("title")
        }
        
        guard let lat = json["latitude"]["value"].string,
            let latitude = Double(lat)
            else {
                throw SerializationError.missing("latitude")
        }
        
        guard let long = json["longitude"]["value"].string,
            let longitude = Double(long)
            else {
                throw SerializationError.missing("longitude")
        }
        
        let coordinates = (latitude, longitude)
        guard case (-90...90, -180...180) = coordinates else {
            throw SerializationError.invalid("coordinates", coordinates)
        }
        
        guard let thumbnail =  json["image"]["value"].string else {
            throw SerializationError.missing("image")
        }
        
        self.thumbnailUrl = thumbnail
        self.coordinates = (latitude, longitude)
        self.title = title
    }
}
