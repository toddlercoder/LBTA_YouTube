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
    
    func fetchVideos(completion: @escaping ([Video]) -> ()) {
        let apiToContact = "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json"
        Alamofire.request(apiToContact).validate().responseJSON() { response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    
                    var videos = [Video]()
                    for dictionary in json.arrayValue {
                        let video = Video(json: dictionary)
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
