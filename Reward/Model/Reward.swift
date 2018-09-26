//
//  Reward.swift
//  goToWork
//
//  Created by 张博 on 2018/9/26.
//  Copyright © 2018年 Devin. All rights reserved.
//

import Foundation
import HandyJSON
struct HistoryRewardList:HandyJSON {
    var res:[HistoryReward]?
}
/*
 company_name : "火枪手数据科技有限公司"
 name : "self"
 premium : "600元"
 username : "张小博"
 date_interview : "18-09-04 04:13:54"
 */
struct HistoryReward:HandyJSON {
    var company_name:String?
    var name:String?
    var premium:String?
    var username:String?
    var date_interview:String?
}
