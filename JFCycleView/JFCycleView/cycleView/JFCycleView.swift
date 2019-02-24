//
//  JFCycleView.swift
//  无限轮播的封装
//
//  Created by iOS_JunFeng on 2019/2/23.
//  Copyright © 2019 JF. All rights reserved.
//

import UIKit
import Kingfisher

private let cycleCellID = "cycleCellID"

class JFCycleView: UIView {
    
    @IBOutlet weak var collectView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    private var currIndex : Int = 0
    
//    //定义block
    typealias callBlock = (_ IndexPathItem :Int) ->()
    //创建block变量
    var didItemCall : callBlock!
    
    
    var cycleTimer: Timer?

    var dataArray : [String]? {
        didSet{
            collectView.reloadData()
            pageControl.numberOfPages = dataArray?.count ?? 0
    
            removeCycleTimer()
            addCycleTimer()
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectView.delegate = self
        collectView.dataSource = self
        collectView.register(UINib (nibName:"JFCycleCell", bundle: nil), forCellWithReuseIdentifier: cycleCellID)

    }
    
    override func layoutSubviews() {
        
        let flowLayout = collectView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = collectView.frame.size
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        
        let indexPath = NSIndexPath(item: (dataArray?.count)! * 100, section: 0)
        collectView.scrollToItem(at:indexPath as IndexPath, at: .left, animated: false)
    }

    
}

extension JFCycleView {
    class func cycleView() -> JFCycleView {
        return Bundle.main.loadNibNamed("JFCycleView", owner: nil, options: nil)?.first as! JFCycleView
    }
}

// MARK:遵循UICollectionViewDatesource协议
extension JFCycleView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (dataArray?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectView.dequeueReusableCell(withReuseIdentifier:cycleCellID , for: indexPath) as! JFCycleCell
        cell.iconImageView.kf.setImage(with: ImageResource(downloadURL:URL.init(string: (dataArray?[indexPath.item % (dataArray?.count)!])!)!))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didItemCall(indexPath.item % (dataArray?.count)!)
    }
}

// MARK:遵循UICollectionViewDeleagate协议
extension JFCycleView: UICollectionViewDelegateFlowLayout {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 1.先获取偏移的X
        let offsetX = scrollView.contentOffset.x
        pageControl.currentPage = Int(offsetX/scrollView.frame.width) % ((dataArray?.count)!)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycleTimer()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        addCycleTimer()
    }
}


extension JFCycleView {
    private func addCycleTimer() {
        cycleTimer = Timer(timeInterval: 3.0, target: self, selector:#selector(self.scrollToNext
            ), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: RunLoop.Mode.default)
    }
    private func removeCycleTimer() {
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
    
    @objc private func scrollToNext() {
        let currentOffsetX = collectView.contentOffset.x
        let offsetX = currentOffsetX + collectView.frame.width
        collectView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
    
}




/*
 id: 288016
 main_id: 72779
 source: 2
 oa_source: 21
 title: 2019英雄联盟职业联赛
 pic_url: https://sta-op.douyucdn.cn/douyu-vrp-admin/2019/01/24/e789003a7f8092b680783094cef30ae2.jpg
 tv_pic_url: https://sta-op.douyucdn.cn/douyu-vrp-admin/2019/01/24/1eeabe3f0221d3133726c0bd7099964e.jpg
 */
