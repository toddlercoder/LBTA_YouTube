//
//  SettingCell.swift
//  YouTube
//
//  Created by Melody Song on 6/20/18.
//  Copyright © 2018 Melody Song. All rights reserved.
//

import UIKit

class SettingCell : BaseCell {
    var setting: Setting? {
        didSet {
            nameLabel.text = setting?.name.rawValue
            if let imageName = setting?.imageName {
                iconImageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
                iconImageView.tintColor = UIColor.darkGray
            }
        }
    }
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Setting"
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    let iconImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "settings")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override var isHighlighted: Bool {
        didSet {
            //print(isHighlighted)
            backgroundColor = isHighlighted ? UIColor.darkGray : UIColor.white
            nameLabel.textColor = isHighlighted ? UIColor.white : UIColor.black
            iconImageView.tintColor = isHighlighted ? UIColor.white : UIColor.darkGray
        }
    }
    
    override func setupViews() {
        super.setupViews()
        
        //backgroundColor = UIColor.blue
        
        addSubview(iconImageView)
        addSubview(nameLabel)
        
        addConstraintsWithFormat(format: "H:|-8-[v0(20)]-16-[v1]|", views: iconImageView, nameLabel)

        addConstraintsWithFormat(format: "V:|[v0]|", views: nameLabel)
        addConstraintsWithFormat(format: "V:[v0(20)]", views: iconImageView)

        addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
}
