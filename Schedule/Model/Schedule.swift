//
//  Schedule.swift
//  goToWork
//
//  Created by 张博 on 2018/9/17.
//  Copyright © 2018年 Devin. All rights reserved.
//

import Foundation
import HandyJSON
/*
 id : "207"
 username : "张小博"
 tel : "15504576825"
 date : "2018-09-04"
 id_card : "230606199307294838"
 company : "362"
 user_id : "oA5Pi5KB-UlTN4L9dk4TzkaMdecA"
 company_id : "16"
 premium : "600元"
 name : "self"
 job : "客服专员"
 company_name : "火枪手数据科技有限公司"
 date_interview : "18-09-04 04:13:54"
 status_jiekuan : "1"
 status_mianshi : "1"
 status_yongjin : "1"
 interview : "江苏省苏州市昆山市花桥镇花安路169号中寰广场"
 status : "1536048760"
 self : "3"
 */
struct ScheduleList:HandyJSON {
    var company:[Schedule]?
}

struct Schedule:HandyJSON {
    var id:String?
    var username:String?
    var tel:String?
    var date:String?
    var id_card:String?
    var company:String?
    var user_id:String?
    var company_id:String?
    var premium:String?
    var name:String?
    var job:String?
    var company_name:String?
    var date_interview:String?
    var status_jiekuan:String?
    var status_mianshi:String?
    var status_yongjin:String?
    var interview:String?
    var status:String?
    
}
