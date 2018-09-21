//
//  PaddingLabel.swift
//  goToWork
//
//  Created by 张博 on 2018/9/21.
//  Copyright © 2018年 Devin. All rights reserved.
//

import UIKit

class LablePadding : UILabel {
    
    var paddingTop : CGFloat = 0
    var paddingBottom : CGFloat = 0
    var paddingLeft : CGFloat = 0
    var paddingRight : CGFloat = 0
    
    convenience init(paddingTop : CGFloat , paddingLeft : CGFloat , paddingBottom : CGFloat , paddingRight : CGFloat ){
        self.init()
        self.paddingTop = paddingTop
        self.paddingLeft = paddingLeft
        self.paddingBottom = paddingBottom
        self.paddingRight = paddingRight
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: UIEdgeInsetsInsetRect(rect, UIEdgeInsets(top: paddingTop, left: paddingLeft, bottom: paddingBottom, right: paddingRight)))
    }
}
