//
//  JobDetailTableViewCell.swift
//  goToWork
//
//  Created by 张博 on 2018/9/20.
//  Copyright © 2018年 Devin. All rights reserved.
//

import Foundation
import UIKit
class CommissionPolicyCell:UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layOutViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    lazy var mettingDate:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.hex(hexString: "#8a8a8a")
        label.numberOfLines = 0
        return label
    }()
    lazy var rewardAmountTitle:UILabel = {
        let label = UILabel()
        label.text = "奖励金额"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.backgroundColor = UIColor.hex(hexString: BasicColor)
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.white
        return label
    }()
    lazy var rewardConditionTitle:UILabel = {
        let label = UILabel()
        label.text = "奖励要求"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.backgroundColor = UIColor.hex(hexString: BasicColor)
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.white
        return label
    }()
    lazy var rewardAmount:UILabel = {
        let label = UILabel()
        label.text = "无"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.backgroundColor = UIColor.hex(hexString: BasicColor)
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.white
        return label
    }()
    lazy var rewardCondition:UILabel = {
        let label = UILabel()
        label.text = "无"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.backgroundColor = UIColor.hex(hexString: BasicColor)
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.white
        return label
    }()
    lazy var rewardIntroduction:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.hex(hexString: "#8a8a8a")
        label.numberOfLines = 0
        return label
    }()
    
    func layOutViews(){
        contentView.addSubview(mettingDate)
        contentView.addSubview(rewardAmountTitle)
        contentView.addSubview(rewardConditionTitle)
        contentView.addSubview(rewardAmount)
        contentView.addSubview(rewardCondition)
        contentView.addSubview(rewardIntroduction)
        
        mettingDate.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview().offset(10)
        }
        rewardConditionTitle.snp.makeConstraints { (make) in
            make.top.equalTo(rewardAmountTitle)
            make.right.equalToSuperview().offset(-10)
            make.width.equalTo(120)
            make.height.greaterThanOrEqualTo(40)
        }
        rewardAmountTitle.snp.makeConstraints { (make) in
            make.top.equalTo(mettingDate.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalTo(rewardConditionTitle.snp.left).offset(-1)
            make.height.greaterThanOrEqualTo(40)
        }
        rewardCondition.snp.makeConstraints { (make) in
            make.top.equalTo(rewardConditionTitle.snp.bottom).offset(1)
            make.right.equalToSuperview().offset(-10)
            make.width.equalTo(120)
            make.height.greaterThanOrEqualTo(40)
        }
        rewardAmount.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(rewardAmountTitle.snp.bottom).offset(1)
            make.right.equalTo(rewardCondition.snp.left).offset(-1)
            make.height.greaterThanOrEqualTo(40)
        }
        rewardIntroduction.snp.makeConstraints { (make) in
            make.top.equalTo(rewardAmount.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    var model:Company? {
        didSet{
            guard let model = model else{ return }
            mettingDate.text = (model.start?.timeIntervalChangeToTimeStr(dateFormat: "yyyy-MM-dd") ?? "xx") + "至" + (model.end?.timeIntervalChangeToTimeStr(dateFormat: "yyyy-MM-dd")  ?? "xx") + "期间参加面试！"
            rewardAmount.text = model.premium ?? "无"
            rewardCondition.text = model.commission ?? "无"
            rewardIntroduction.text = "您可以帮助他人报名，您来赚取推荐佣金；您也可以自己求职，为自己报名，您拿推荐奖金。"
        }
    }
}

class JobDescriptionCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor.groupTableViewBackground
        layOutViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    lazy var item_job: LablePadding = {
        let label = LablePadding(paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0)
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.hex(hexString: "#8a8a8a")
        label.backgroundColor = UIColor.white
        label.numberOfLines = 0
        return label
    }()
    lazy var item_commission:LablePadding = {
        let label = LablePadding(paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0)
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.hex(hexString: "#8a8a8a")
        label.backgroundColor = UIColor.white
        label.numberOfLines = 0
        return label
    }()
    lazy var item_welfWare:LablePadding = {
        let label = LablePadding(paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0)
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.hex(hexString: "#8a8a8a")
        label.backgroundColor = UIColor.white
        label.numberOfLines = 0
        return label
    }()
    lazy var item_company:LablePadding = {
        let label = LablePadding(paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0)
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.hex(hexString: "#8a8a8a")
        label.backgroundColor = UIColor.white
        label.numberOfLines = 0
        return label
    }()
    lazy var item_address:LablePadding = {
        let label = LablePadding(paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0)
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.hex(hexString: "#8a8a8a")
        label.backgroundColor = UIColor.white
        label.numberOfLines = 0
        return label
    }()
    lazy var item_number:LablePadding = {
        let label = LablePadding(paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0)
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.hex(hexString: "#8a8a8a")
        label.backgroundColor = UIColor.white
        label.numberOfLines = 0
        return label
    }()
    lazy var item_sex:LablePadding = {
        let label = LablePadding(paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0)
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.hex(hexString: "#8a8a8a")
        label.backgroundColor = UIColor.white
        label.numberOfLines = 0
        return label
    }()
    lazy var item_age:LablePadding = {
        let label = LablePadding(paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0)
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.hex(hexString: "#8a8a8a")
        label.backgroundColor = UIColor.white
        label.numberOfLines = 0
        return label
    }()
    lazy var item_education:LablePadding = {
        let label = LablePadding(paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0)
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.hex(hexString: "#8a8a8a")
        label.backgroundColor = UIColor.white
        label.numberOfLines = 0
        return label
    }()
    lazy var item_experience:LablePadding = {
        let label = LablePadding(paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0)
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.hex(hexString: "#8a8a8a")
        label.backgroundColor = UIColor.white
        label.numberOfLines = 0
        return label
    }()
    
    func layOutViews() {
        contentView.addSubview(item_job)
        contentView.addSubview(item_commission)
        contentView.addSubview(item_welfWare)
        contentView.addSubview(item_company)
        contentView.addSubview(item_address)
        contentView.addSubview(item_number)
        contentView.addSubview(item_sex)
        contentView.addSubview(item_age)
        contentView.addSubview(item_education)
        contentView.addSubview(item_experience)
        
        item_job.snp.makeConstraints { (make) in
            make.top.right.equalToSuperview()
            make.left.equalToSuperview()
            make.height.greaterThanOrEqualTo(40)
        }
        item_commission.snp.makeConstraints { (make) in
            make.top.equalTo(item_job.snp.bottom).offset(1)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.greaterThanOrEqualTo(40)
        }
        item_welfWare.snp.makeConstraints { (make) in
            make.top.equalTo(item_commission.snp.bottom).offset(1)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.greaterThanOrEqualTo(40)
        }
        item_company.snp.makeConstraints { (make) in
            make.top.equalTo(item_welfWare.snp.bottom).offset(1)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.greaterThanOrEqualTo(40)
        }
        item_address.snp.makeConstraints { (make) in
            make.top.equalTo(item_company.snp.bottom).offset(1)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.greaterThanOrEqualTo(40)
        }
        item_number.snp.makeConstraints { (make) in
            make.top.equalTo(item_address.snp.bottom).offset(1)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.greaterThanOrEqualTo(40)
        }
        item_sex.snp.makeConstraints { (make) in
            make.top.equalTo(item_number.snp.bottom).offset(1)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.greaterThanOrEqualTo(40)
        }
        item_age.snp.makeConstraints { (make) in
            make.top.equalTo(item_sex.snp.bottom).offset(1)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.greaterThanOrEqualTo(40)
        }
        item_education.snp.makeConstraints { (make) in
            make.top.equalTo(item_age.snp.bottom).offset(1)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.greaterThanOrEqualTo(40)
        }
        item_experience.snp.makeConstraints { (make) in
            make.top.equalTo(item_education.snp.bottom).offset(1)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.greaterThanOrEqualTo(40)
            make.bottom.equalToSuperview()
        }
    }
    
    var model:Company? {
        didSet{
            guard let model = model else {
                return
            }
            item_job.text = "招聘岗位 \(model.job ?? "")"
            item_commission.text = "薪资待遇 \(model.compensation ?? "")"
            item_welfWare.text = "基本福利 \(model.welfare ?? "")"
            item_company.text = "企业名称  \(model.company ?? "")"
            item_address.text = "工作地点 \(model.address ?? "")"
            item_number.text = "招聘人数 \(model.population ?? "")"
            item_sex.text = "性别要求 \(model.sex ?? "")"
            item_age.text = "年龄要求 \(model.age ?? "")"
            item_education.text = "学历要求 \(model.education ?? "")"
            item_experience.text = "经验要求 \(model.experience ?? "")"
            
        }
    }
}

class CommissionIntroductionCell: UITableViewCell {
    private  lazy var introduction:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.backgroundColor = UIColor.white
        label.textColor = UIColor.hex(hexString: "#8a8a8a")
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layOutViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layOutViews() {
        contentView.addSubview(introduction)
        introduction.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsetsMake(10, 10, 10, 10))
        }
    }
    
    var model:Company? {
        didSet{
            guard let model = model else {
                return
            }
            introduction.text = model.yongjin ?? "无"
        }
    }
}
