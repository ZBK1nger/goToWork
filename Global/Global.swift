//
//  Global.swift
//  goToWork
//
//  Created by 张博 on 2018/9/13.
//  Copyright © 2018年 Devin. All rights reserved.
//

import Foundation
import UIKit

/************************  屏幕尺寸  ***************************/
// 屏幕宽度
let SCREEN_WIDTH = UIScreen.main.bounds.size.width

// 屏幕高度
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

// 比例系数（相对于iphone6）
let SCALE_X = SCREEN_WIDTH / 375

let SCALE_Y = SCREEN_HEIGHT / 667

// iPhone4
let isIphone4 = SCREEN_HEIGHT  < 568 ? true : false

// iPhone 5
let isIphone5 = SCREEN_HEIGHT  == 568 ? true : false

// iPhone 6
let isIphone6 = SCREEN_HEIGHT  == 667 ? true : false

// iphone 6P
let isIphone6P = SCREEN_HEIGHT == 736 ? true : false

// iphone X
let IPHONEX = SCREEN_HEIGHT >= 812 ? true : false

// navigationBarHeight
let NAVIGATION_BAR_HEIGHT : CGFloat = IPHONEX ? 88 : 64

// tabBarHeight
let TAB_BAR_HEIGHT : CGFloat = IPHONEX ? 49 + 34 : 49

// home indicator
let HOME_INDICATOR_HEIGHT:CGFloat =  (IPHONEX ? 34 : 0)

let BasicColor = "#5ac8fa"


var window: UIViewController? {
    var resultVC: UIViewController?
    resultVC = _window(UIApplication.shared.keyWindow?.rootViewController)
    while resultVC?.presentedViewController != nil {
        resultVC = _window(resultVC?.presentedViewController)
    }
    return resultVC
}

private  func _window(_ vc: UIViewController?) -> UIViewController? {
    if vc is UINavigationController {
        return _window((vc as? UINavigationController)?.topViewController)
    } else if vc is UITabBarController {
        return _window((vc as? UITabBarController)?.selectedViewController)
    } else {
        return vc
    }
}
