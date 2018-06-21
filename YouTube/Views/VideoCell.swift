//
//  VideoCell.swift
//  YouTube
//
//  Created by Melody Song on 6/19/18.
//  Copyright © 2018 Melody Song. All rights reserved.
//

import UIKit
import Kingfisher

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class VideoCell : BaseCell {

    var video: Video? {
        didSet {
            titleLabel.text = video?.title
            setupThumbnailImage()
            setupChannelImage()
            if let channelName = video?.channel?.name, let numberofViews = video?.numberOfViews {
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                let numViews = numberFormatter.string(from: numberofViews)
                let subtitleText = "\(channelName)  - \(String(describing: numViews)) - 2 years ago"
                
                subtitleTextView.text = subtitleText
            }
        }
    }
    
    /*func setupImage(url: String, imageView : UIImageView) {
        if let imageURL = url {
            imageView.af_setImage(withURL: URL(string: imageURL)!)
        }
    }*/
    //let imageCache = NSCache()
    
    func setupThumbnailImage() {
        if let thumbnailImageURL = video?.thumbnailImageName {
            userProfileImageView.kf.setImage(with: URL(string: thumbnailImageURL)!)
        }
    }
    
    func setupChannelImage() {
        if let profileImageURL = video?.channel?.profileImageName {
            thumbnailImageView.kf.setImage(with: URL(string: profileImageURL)!)
        }
    }
    
    // MARK : Outlets
    let thumbnailImageView : UIImageView = {
        let imageView = UIImageView()
        //imageView.backgroundColor = .blue
        imageView.image = UIImage(named: "mel")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        //imageView.backgroundColor = .green
        imageView.image = UIImage(named: "SOULEM")
        imageView.layer.cornerRadius = 22
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let separatorView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/250, green: 230/250, blue: 230/250, alpha: 1)
        
        return view
    }()
    
    let titleLabel : UILabel = {
        let label = UILabel()
        //label.backgroundColor = .purple
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Taylor Swift - Blank Space"
        label.numberOfLines = 2
        return label
    }()
    
    let subtitleTextView: UITextView = {
        let textView = UITextView()
        //textView.backgroundColor = .red
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "TaylorSwiftVEVNO - 1,605,123,094 views - 2 years ago"
        textView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
        textView.textColor = UIColor.lightGray
        return textView
    }()
    
    var titleLabelHeightConstraint: NSLayoutConstraint?
    
    override func setupViews() {
        addSubview(thumbnailImageView)
        addSubview(separatorView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subtitleTextView)
        
        // horizontal constraints
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: thumbnailImageView)
        addConstraintsWithFormat(format: "H:|-16-[v0(44)]|", views: userProfileImageView)
        // vertical constraints
        addConstraintsWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-16-[v2(1)]|", views: thumbnailImageView, userProfileImageView, separatorView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: separatorView)
        
        // MARK - titleLabel
        // top constraints
        addConstraints([NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8)])
        // left constraint
        addConstraints([NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8)])
        // right constraint
        addConstraints([NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0)])
        // height constraint
        addConstraints([NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20)])
        
        // MARK - subtitleTextView
        // top constraints
        addConstraints([NSLayoutConstraint(item: subtitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4)])
        // left constraint
        addConstraints([NSLayoutConstraint(item: subtitleTextView, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8)])
        // right constraint
        addConstraints([NSLayoutConstraint(item: subtitleTextView, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0)])
        // height constraint
        addConstraints([NSLayoutConstraint(item: subtitleTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30)])
        
    }
}
