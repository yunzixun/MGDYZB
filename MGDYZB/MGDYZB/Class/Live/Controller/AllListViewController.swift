//
//  AllListViewController.swift
//  MGDYZB
//
//  Created by ming on 16/10/30.
//  Copyright © 2016年 ming. All rights reserved.
// 

import UIKit

class AllListViewController: BaseViewController {
    
    // MARK:- ViewModel
    private lazy var allListVM : AllListViewModel = AllListViewModel()

    private lazy var collectionView : UICollectionView = {[weak self] in
        // 1.创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSizeMake(kNormalItemW, kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSizeMake(kScreenW, kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        // 2.创建UICollectionView
        let collectionView = UICollectionView(frame: self!.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.scrollsToTop = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        
        // 3.注册
        collectionView.registerNib(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


// MARK: - 初始化UI
extension AllListViewController {
    override func setUpUI()  {
        // 0.给ContentView进行赋值
        contentView = collectionView
        
        view.addSubview(collectionView)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        super.setUpUI()
    }
}

extension AllListViewController{
    private func loadData() {
        allListVM.loadAllListData { [unowned self]() -> () in
            self.collectionView.reloadData()
            
            self.loadDataFinished()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension AllListViewController: UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allListVM.rooms.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        // 1.取出Cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(kNormalCellID, forIndexPath: indexPath) as! CollectionNormalCell
        
        // 2.给cell设置数据
        cell.anchor = allListVM.rooms[indexPath.item]
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension AllListViewController: UICollectionViewDelegate {

}

