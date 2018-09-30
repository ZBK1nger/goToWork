//
//  Job.swift
//  goToWork
//
//  Created by 张博 on 2018/9/14.
//  Copyright © 2018年 Devin. All rights reserved.
//

import Foundation
import HandyJSON
// MARK - 职位
struct PositionList: HandyJSON {
    var data:[Position]?
}
struct Position:HandyJSON {
    var id:String?
    var name:String?
}

// MARK - 招聘公司信息
struct CompanyList:HandyJSON {
    var id:String?
    var company:String?
    var job:String?
    var population:String?
    var premium:String?
    var address:String?
    var start:String?
    var end:String?
    var interview:String?
    var compensation:String?
    var commission:String?
    var welfare:String?
    var age:String?
    var education:String?
    var experience:String?
    var title:String?
    var job_content:String?
    var base_salary:String?
    var work_time:String?
    var other_work:String?
    var eat:String?
    var live:String?
    var sex:String?
    var other_admit:String?
    var pic:String?
    var other_welfare:String?
    var company_pic:String?
    var company_id:String?
    var yongjin:String?
    var hits:String?
    var sheng:String?
    var city:String?
    var createtime:String?
    var updatetime:String?
    var sort:String?
    var list:[Company]?
    var collapsed: Bool? = true
}
 struct Company:HandyJSON {
    var id:String?
    var company:String?
    var job:String?
    var population:String?
    var premium:String?
    var address:String?
    var start:String?
    var end:String?
    var interview:String?
    var compensation:String?
    var commission:String?
    var welfare:String?
    var age:String?
    var education:String?
    var experience:String?
    var title:String?
    var job_content:String?
    var base_salary:String?
    var work_time:String?
    var other_work:String?
    var eat:String?
    var live:String?
    var sex:String?
    var other_admit:String?
    var pic:String?
    var other_welfare:String?
    var company_pic:String?
    var company_id:String?
    var yongjin:String?
    var hits:String?
    var sheng:String?
    var city:String?
    var createtime:String?
    var updatetime:String?
    var sort:String?
}

struct RecruitmentBrief:HandyJSON {
    var id:String?
    var company:String?
    var title:String?
    var job:String?
    var address:String?
    var base_salary:String?
    var compensation:String?
    var job_content:String?
    var work_time:String?
    var other_welfare:String?
    var pay_time:String?
    var eat:String?
    var live:String?
    var age:String?
    var education:String?
    var sex:String?
    var experience:String?
    var other_work:String?
    var other_admit:String?
}
