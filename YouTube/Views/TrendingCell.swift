//
//  TrendingCell.swift
//  YouTube
//
//  Created by Melody Song on 6/21/18.
//  Copyright © 2018 Melody Song. All rights reserved.
//

import UIKit

class TrendingCell: FeedCell {
    override func fetchVideos() {
        ApiService.sharedInstance.fetchTrendingFeed { (videos: [Video]) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
}
