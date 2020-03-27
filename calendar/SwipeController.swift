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

class SwipeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    @objc func handlePrev() {
        var nextIndex = pageControl.currentPage - 1;
        if (nextIndex < 0) {
            nextIndex += pageControl.numberOfPages
        }
        
        pageControl.currentPage = nextIndex;
        let indexPath = IndexPath(item: nextIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    @objc func handleNext() {
        var nextIndex = pageControl.currentPage + 1;
        if (nextIndex >= pageControl.numberOfPages) {
            nextIndex -= pageControl.numberOfPages
        }
        
        pageControl.currentPage = nextIndex;
        let indexPath = IndexPath(item: nextIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(NSLocalizedString("next", comment: "下一个强者"), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return button
    }()
    
    let prevButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(NSLocalizedString("prev", comment: "上一个强者"), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(handlePrev), for: .touchUpInside)
        return button
    }()
    
    let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.numberOfPages = strongManList.count
        pageControl.currentPageIndicatorTintColor = .label
        pageControl.pageIndicatorTintColor = .secondaryLabel
        return pageControl
    }()
    
    func load() {
        let bottomStackView = UIStackView(arrangedSubviews: [prevButton, pageControl, nextButton])
        bottomStackView.distribution = .fillEqually

        view.addSubview(bottomStackView)
        bottomStackView.snp.makeConstraints{ (make) -> Void in
            make.height.equalTo(50)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.trailing.equalTo(view)
            make.leading.equalTo(view)
        }
        
        collectionView?.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(bottomStackView.snp.top)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView?.register(StrongManCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView?.isPagingEnabled = true
        collectionView?.backgroundColor = .systemBackground
        
        load()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return strongManList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! StrongManCell
        
        cell.strongMan = strongManList[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (_) in
            self.collectionViewLayout.invalidateLayout()

            if self.pageControl.currentPage == 0 {
                self.collectionView?.contentOffset = .zero
            } else {
                let indexPath = IndexPath(item: self.pageControl.currentPage, section: 0)
                self.collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }

        })
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        pageControl.currentPage = Int(x / view.frame.width)
    }
}
