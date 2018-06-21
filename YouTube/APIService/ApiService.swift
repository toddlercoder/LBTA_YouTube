//
//  ApiService.swift
//  YouTube
//
//  Created by Melody Song on 6/20/18.
//  Copyright © 2018 Melody Song. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import AlamofireImage
import AlamofireNetworkActivityIndicator

class ApiService: NSObject {
    
    static let sharedInstance = ApiService()
    let domainURL = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/")
    
    func fetchVideos(completion: @escaping ([Video]) -> ()) {
        /*fetchFeedForURLString(urlString: "home") { (videos) in
            completion(videos)
        }*/
        fetchFeedForURLString(urlString: "home", completion: completion)
    }
    
    func fetchTrendingFeed(completion: @escaping ([Video]) -> ()) {
        /*fetchFeedForURLString(urlString: "trending") { (videos) in
            completion(videos)
        }*/
        fetchFeedForURLString(urlString: "trending", completion: completion)
    }
    
    func fetchSubscriptionFeed(completion: @escaping ([Video]) -> ()) {
        /*fetchFeedForURLString(urlString: "subscriptions") { (videos) in
            completion(videos)
        }*/
        fetchFeedForURLString(urlString: "subscriptions", completion: completion)
    }
    
    func fetchFeedForURLString(urlString: String, completion: @escaping ([Video]) -> ()) {
        let url  = domainURL?.appendingPathComponent("\(urlString).json")
        Alamofire.request(url!).validate().responseJSON() { response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    
                    var videos = [Video]()
                    for dictionary in json.arrayValue {
                        let video = Video(json: dictionary)
                        // setValuesForKeysWithDictionary(dictionary)
                        videos.append(video)
                    }
                    print(json)
                    
                    DispatchQueue.main.async {
                        completion(videos)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
