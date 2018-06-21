//
//  FeedCell.swift
//  YouTube
//
//  Created by Melody Song on 6/21/18.
//  Copyright © 2018 Melody Song. All rights reserved.
//

import UIKit

class FeedCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    let cellId = "cellId"
    var videos: [Video]?
    
    func fetchVideos() {
        ApiService.sharedInstance.fetchVideos{ (videos: [Video]) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
    
    override func setupViews() {
        //backgroundColor = UIColor.brown
        super.setupViews()
        fetchVideos()
        
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0
     }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCell
     //cell.backgroundColor = .red
        cell.video = videos?[indexPath.item]
        return cell
     }
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (frame.width - 16 - 16) * 9/16
        return CGSize(width: frame.width, height: height + 16 + 68)
     }
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
     }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let videoLauncher = VideoLauncher()
        videoLauncher.showVideoPlayer()
    }
}
