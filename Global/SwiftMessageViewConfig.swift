//
//  SwiftMessageViewConfig.swift
//  goToWork
//
//  Created by 张博 on 2018/9/30.
//  Copyright © 2018年 Devin. All rights reserved.
//

import Foundation
import UIKit
import SwiftMessages
enum ToastCardType {
    case success
    case error
    case warning
    case info
}
class SwiftMessageViewConfig {
     class func show(type:ToastCardType,title:String,body:String) {
        switch type {
        case .success:
            let success = MessageView.viewFromNib(layout: .cardView)
            success.configureTheme(.success)
            success.configureContent(title: title, body: body)
            success.button?.isHidden = true
            SwiftMessages.show(view: success)
        case .error:
            let error = MessageView.viewFromNib(layout: .tabView)
            error.configureTheme(.error)
            error.configureContent(title: title, body: body)
            error.button?.isHidden = true
            SwiftMessages.show(view: error)
        case .info:
            let info = MessageView.viewFromNib(layout: .messageView)
            info.configureTheme(.info)
            info.button?.isHidden = true
            info.configureContent(title: title, body: body)
            var infoConfig = SwiftMessages.defaultConfig
            infoConfig.presentationStyle = .bottom
            infoConfig.duration = .seconds(seconds: 0.25)
            SwiftMessages.show(config: infoConfig, view: info)
        case .warning:
            let warning = MessageView.viewFromNib(layout: .cardView)
            warning.configureTheme(.warning)
            warning.configureDropShadow()
            warning.configureContent(title: title, body: body)
            warning.button?.isHidden = true
            SwiftMessages.show(view: warning)
        }
    }
}
