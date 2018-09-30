//
//  String+Extension.swift
//  WKWebViewSwift
//
//  Created by XiaoFeng on 2017/10/20.
//  Copyright © 2017年 XiaoFeng. All rights reserved.
//

import Foundation

enum verifyType{
    
    case Other
    case PhoneNumber
    case IdentityCard
    
}
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
    
    //正则验证
    func verifyText(type: verifyType) -> Bool{
        
        switch type {
        case .PhoneNumber:
            
            /*
             * 所有手机号
             * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[6, 7, 8], 18[0-9], 170[0-9]
             */
            let MOBILE = "^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678])\\d{8}$"
            
            /*
             * 中国移动 China Mobile
             * 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
             */
            let CM = "(^1(3[4-9]|5[0-27-9]|8[2-478]|47|78)\\d{8}$)|(^1705\\d{7}$)"
            
            /*
             * 中国联通 China Unicom
             * 130,131,132,155,156,185,186,145,176,1709
             */
            let CU = "(^1(3[0-2]|5[56]|8[56]|45|76)\\d{8}$)|(^1709\\d{7}$)"
            
            /*
             *中国电信 China Telecom
             *133,153,180,181,189,177,1700
             */
            let CT = "(^1(33|53|8[019]|77)\\d{8}$)|(^1700\\d{7}$)"
            
            //谓词
            let RegexTestMobile = NSPredicate.init(format: "SELF MATCHES %@", MOBILE)
            let RegexTestCM = NSPredicate.init(format: "SELF MATCHES %@", CM)
            let RegexTestCU = NSPredicate.init(format: "SELF MATCHES %@", CU)
            let RegexTestCT = NSPredicate.init(format: "SELF MATCHES %@", CT)
            
            if RegexTestMobile.evaluate(with: self) || RegexTestCM.evaluate(with: self) || RegexTestCU.evaluate(with: self) || RegexTestCT.evaluate(with: self) {
                return true
            }else{
                return false
            }
            
        case .IdentityCard:
            
            /*
             xxxxxx yyyy MM dd 375 0     十八位
             
             地区：[1-9]\d{5}
             年的前两位：(19|20)            1900-20xx 暂时只能是19和20开头
             年的后两位：\d{2}
             月份：(0[1-9]|1[0-2])
             天数：([0-2][1-9]|[1-3]0|31)          没判断闰年29
             
             三位顺序码：\d{3}
             校验码：[0-9Xx]
             
             十八位："(^[1-9]\\d{5}(19|20)\\d{2}(0[1-9]|1[0-2])([0-2][1-9]|[1-3]0|31)\\d{3}[0-9Xx]$)"
             */
            let id = "(^[1-9]\\d{5}(19|20)\\d{2}(0[1-9]|1[0-2])([0-2][1-9]|[1-3]0|31)\\d{3}[0-9Xx]$)"
            let RegexTestid = NSPredicate.init(format: "SELF MATCHES %@", id)
            return RegexTestid.evaluate(with: self)
            
        default:
            return false
        }
    }
}

