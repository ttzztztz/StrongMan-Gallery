//
//  StrongManView.swift
//  calendar
//
//  Created by 杨子越 on 2020/3/25.
//  Copyright © 2020 Rabbit. All rights reserved.
//

import UIKit
import SnapKit
import SwiftUI

class StrongManCell: UICollectionViewCell {
    var strongMan: StrongMan? {
        didSet {
            guard strongMan != nil else { return }
            imageView.image = UIImage(named: strongMan!.id)
            
            let attributedText = NSMutableAttributedString(string: strongMan!.name, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18),NSAttributedString.Key.foregroundColor: UIColor.label])
            attributedText.append(NSAttributedString(string: "\n\n\(strongMan!.description)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel]))
            
            textView.attributedText = attributedText
            textView.textAlignment = .center
            textView.isEditable = false
            textView.isScrollEnabled = false
        }
    }
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        
        image.image = UIImage(named: "hzy")
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    private let textView: UITextView = {
        let text = UITextView()
        
        let attributedText = NSMutableAttributedString(string: "", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18), NSAttributedString.Key.foregroundColor: UIColor.label])
        attributedText.append(NSAttributedString(string: "\n\n", attributes: [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel]))

        text.attributedText = attributedText
        text.textAlignment = .center
        text.isEditable = false
        text.isScrollEnabled = false
        
        return text
    }()
    
    private func load() {
        addSubview(imageView)
        imageView.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(self).offset(30)
            make.trailing.equalTo(self).offset(-30)
            make.width.equalTo(self.snp.width).offset(-60)
            make.top.equalTo(self.snp.top).offset(20)
            make.height.lessThanOrEqualTo(self.snp.height).multipliedBy(0.6)
        }
        
        addSubview(textView)
        textView.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(imageView.snp.bottom)
            make.bottom.equalTo(self.snp.bottom)
            make.trailing.equalTo(self)
            make.leading.equalTo(self)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        load()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func willTransition(from oldLayout: UICollectionViewLayout, to newLayout: UICollectionViewLayout) {
        invalidateIntrinsicContentSize()
    }
}
