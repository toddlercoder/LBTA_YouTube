//
//  Video.swift
//  YouTube
//
//  Created by Melody Song on 6/19/18.
//  Copyright © 2018 Melody Song. All rights reserved.
//

import UIKit
import SwiftyJSON

class Video: NSObject {
    var thumbnailImageName: String?
    var title: String?
    var channel: Channel?
    var numberOfViews: NSNumber?
    var uploadDate: NSDate?
    var duration: Int?
    
    init(json: JSON) {
        self.thumbnailImageName = json["thumbnail_image_name"].stringValue
        self.title = json["title"].stringValue
        self.numberOfViews = json["number_of_views"].int64Value as NSNumber
        self.channel = Channel(json: json["channel"])
        self.duration = json["duration"].intValue
    }
}

class Channel: NSObject {
    var name: String?
    var profileImageName: String?
    
    init(json: JSON) {
        self.name = json["name"].stringValue
        self.profileImageName = json["profile_image_name"].stringValue
    }
}
