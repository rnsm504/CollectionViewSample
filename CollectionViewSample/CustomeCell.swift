//
//  CustomeCell.swift
//  CollectionViewSample
//
//  Created by Masanori Kuze on 2016/01/11.
//  Copyright © 2016年 Masanori Kuze. All rights reserved.
//

import UIKit

class CustomCell : UICollectionViewCell {
    

    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var timeLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        self.userInteractionEnabled = true
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
//        self.userInteractionEnabled = true
        
        let backgroundView = UIView(frame: frame)
        backgroundView.backgroundColor = UIColor.whiteColor()
        self.backgroundView = backgroundView
        
        let selectedBGView = UIView(frame: frame)
        selectedBGView.backgroundColor = UIColor.redColor()
        self.selectedBackgroundView = selectedBGView
    }
    
}