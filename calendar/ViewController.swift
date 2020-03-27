//
//  ViewController.swift
//  calendar
//
//  Created by 杨子越 on 2020/3/23.
//  Copyright © 2020 Rabbit. All rights reserved.
//

import UIKit
import SwiftUI
import SnapKit

class ViewController: UIViewController {
    private lazy var strongManController: SwipeController = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        return SwipeController(collectionViewLayout: layout)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipeView = strongManController.view!
        view.addSubview(swipeView)

        swipeView.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.equalTo(view)
            make.trailing.equalTo(view)
        }
        
    }
}
