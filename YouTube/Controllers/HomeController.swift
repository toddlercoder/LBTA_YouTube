//
//  ViewController.swift
//  YouTube
//
//  Created by Melody Song on 6/18/18.
//  Copyright © 2018 Melody Song. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {


    let cellId = "cellId"
    let trendingCellId = "trendingCellId"
    let subscriptionCellId = "subscriptionCellId"
    
    var titleLabel: UILabel?
    let titles = ["Home", "Trending", "Subscription", "Account"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        navigationController?.navigationBar.isTranslucent = false
        
        collectionView?.backgroundColor = UIColor.white
        
        titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel?.text = "  Home"
        titleLabel?.textColor = .white
        titleLabel?.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
        setupCollectionView()
        setupMenuBar()
        setupNavBarButtons()
    }
    
    func setupCollectionView() {
        // Horizontal SCROLL
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        //collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        //collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(TrendingCell.self, forCellWithReuseIdentifier: trendingCellId)
        collectionView?.register(SubscriptionCell.self, forCellWithReuseIdentifier: subscriptionCellId)
        
        // HomeController to start right below menu bar
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        
        // gap between page !!
        collectionView?.isPagingEnabled = true
    }
    
    
    lazy var menuBar : MenuBar = {
        let mb = MenuBar()
        mb.homeController = self
        return mb
        }()
    
    private func setupMenuBar() {
        // hides when scroll
        navigationController?.hidesBarsOnSwipe = true
        
        // a red view resides behind the menu bar for smoother experience
        let redView = UIView()
        redView.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        view.addSubview(redView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: redView)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: redView)
        
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: menuBar)
        // topLayoutGuide
        menuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    }
    
    func setupNavBarButtons() {
        let searchImage = UIImage(named: "search")?.withRenderingMode(.alwaysOriginal)
        
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        searchBarButtonItem.tintColor = UIColor.white
        
        let moreImage = UIImage(named: "navigation")?.withRenderingMode(.alwaysOriginal)
        let moreButton = UIBarButtonItem(image: moreImage, style: .plain, target: self, action: #selector(handleMore))
       // moreButton.color
        moreButton.tintColor = UIColor.white
        
        navigationItem.rightBarButtonItems = [moreButton, searchBarButtonItem]
    }
    
    lazy var settingLauncher : SettingLauncher = {
        let launcher = SettingLauncher()
        launcher.homeController = self
        return launcher
    }()
    
    @objc func handleMore() {
        //settingLauncher.homeController = self
        settingLauncher.showSettings()
    }

    @objc func handleSearch() {
        //print("123")
        //showControllerForSettings()
        scrollToMenuIndex(menuIndex: 2)
    }

    
    private func setTitleForIndex(index: Int) {
        if let titleLabel = navigationItem.titleView as? UILabel {
            titleLabel.text = "  \(titles[index])"
        }
    }
    
    func scrollToMenuIndex(menuIndex: Int) {
        let indexPath = NSIndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath as IndexPath, at: [], animated: true)
        // Update title
        setTitleForIndex(index: menuIndex)
    }
    
    func showControllerForSetting(setting: Setting) {
        let dummySettingsViewController = UIViewController()
        dummySettingsViewController.view.backgroundColor = UIColor.white
        dummySettingsViewController.navigationItem.title = setting.name.rawValue
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationController?.pushViewController(dummySettingsViewController, animated: true)
    }
    
    // HORIZONTAL SCROLL
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //print(scrollView.contentOffset.x)
        
        menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 4
    }

    
    // menu icons
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    
        let index = targetContentOffset.pointee.x / view.frame.width
        let indexPath = NSIndexPath(item: Int(index), section: 0)
        
        menuBar.collectionView.selectItem(at: indexPath as IndexPath, animated: true, scrollPosition: [])
        // Update title
        setTitleForIndex(index: Int(index))
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var identifier: String
        switch indexPath.item {
            case 1:
                identifier = trendingCellId
            case 2:
                identifier = subscriptionCellId
            default:
                identifier = cellId
        }
        return collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 50)
    }
    
    

}




