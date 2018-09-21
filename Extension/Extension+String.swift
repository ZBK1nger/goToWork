//
//  String+Extension.swift
//  WKWebViewSwift
//
//  Created by XiaoFeng on 2017/10/20.
//  Copyright © 2017年 XiaoFeng. All rights reserved.
//

import Foundation

extension String {
    /// 截取字符串
    ///
    /// - Parameter index: 截取从index位开始之前的字符串
    /// - Returns: 返回一个新的字符串
    func mySubString(to index: Int) -> String {
        return String(self[..<self.index(self.startIndex, offsetBy: index)])
    }
    /// 截取字符串
    ///
    /// - Parameter index: 截取从index位开始到末尾的字符串
    /// - Returns: 返回一个新的字符串
    func mySubString(from index: Int) -> String {
        return String(self[self.index(self.startIndex, offsetBy: index)...])
    }
    
    func timeIntervalChangeToTimeStr(dateFormat:String?) -> String {
        //如果服务端返回的时间戳精确到毫秒，需要除以1000,否则不需要
        let timeInterval = Double(self)
        let date:NSDate = NSDate.init(timeIntervalSince1970: timeInterval!)
        let formatter = DateFormatter.init()
        if dateFormat == nil {
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        }else{
            formatter.dateFormat = dateFormat
        }
        return formatter.string(from: date as Date)
    }
    
     func timeStrChangeToTimeInterval(dateFormat:String?) -> TimeInterval {
        let formatter = DateFormatter.init()
        if dateFormat == nil {
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        }else{
            formatter.dateFormat = dateFormat
        }
        let date = formatter.date(from: self)! as NSDate
        return date.timeIntervalSince1970
    }
}

