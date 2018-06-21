//
//  VideoLauncher.swift
//  YouTube
//
//  Created by Melody Song on 6/21/18.
//  Copyright © 2018 Melody Song. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .black
        
        let urlString = "https://firebasestorage.googleapis.com/v0/b/gameofchats-762ca.appspot.com/o/message_movies%2F12323439-9729-4941-BA07-2BAE970967C7.mov?alt=media&token=3e37a093-3bc8-410f-84d3-38332af9c726"
        
        if let url = URL(string: urlString) {
            let player = AVPlayer(url: url)
            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            player.play()
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class VideoLauncher : NSObject {
    
    func showVideoPlayer() {
        print("Showing video player animation...")
        if let keyWindow = UIApplication.shared.keyWindow {
            let view = UIView(frame: keyWindow.frame)
            
            view.backgroundColor = .white
            
            view.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 10, width: 10, height: 10)
            
            // 16 x 9 is the aspect ratio of all HD videos
            let videoHeight = keyWindow.frame.width * 9 / 16
            let videoPlayerFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: videoHeight)
            let videoPlayerView = VideoPlayerView(frame: videoPlayerFrame)
            view.addSubview(videoPlayerView)

            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                view.frame = keyWindow.frame
                
            }, completion: { (completedAnimation) in
                UIApplication.shared.setStatusBarHidden(true, with: .fade)
                // UIApplication.shared.isStatusBarHidden = true
            })
            
            keyWindow.addSubview(view)
        }
        
    }
}
