//
//  ViewController.swift
//  JFCycleView
//
//  Created by iOS_JunFeng on 2019/2/24.
//  Copyright © 2019 JF. All rights reserved.
//

import UIKit

private let kCycleViewH : CGFloat = 180

class ViewController: UIViewController {

    private lazy var cycleView: JFCycleView = {
        let cycleView = JFCycleView.cycleView()
        cycleView.frame = CGRect(x: 0, y: 100, width: 375, height: kCycleViewH)
        return cycleView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.addSubview(cycleView)
        
        cycleView.dataArray = ["https://sta-op.douyucdn.cn/douyu-vrp-admin/2019/01/24/1eeabe3f0221d3133726c0bd7099964e.jpg",
                               "https://sta-op.douyucdn.cn/douyu-vrp-admin/2019/02/18/b73f807d928eb51b84c1da1386b8d6f3.jpg",
                               "https://sta-op.douyucdn.cn/douyu-vrp-admin/2019/02/18/4db5c47c7e8c13e94b2fc61b3cf9b851.jpg",
                               "https://cs-op.douyucdn.cn/douyu-vrp-admin/2018/04/16/82f2a2ae2268e9cb29226e396aba56a4.jpg",
                               "https://sta-op.douyucdn.cn/douyu-vrp-admin/2019/02/22/3b2a5e7d057dfb45ad8b4628d72cd733.jpg"
        ]
        
        
        
        
        
    }
}

