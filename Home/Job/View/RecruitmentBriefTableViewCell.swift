//
//  RecruitmentBriefTableViewCell.swift
//  goToWork
//
//  Created by 张博 on 2018/9/30.
//  Copyright © 2018年 Devin. All rights reserved.
//

import Foundation
import UIKit

class RecruitmentBriefHeaderCell: UITableViewCell {
    lazy var companyName:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    lazy var compensation:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.hex(hexString: BasicColor)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    lazy var item_age:UIButton = {
        let btn = UIButton(type: .custom)
        btn .setTitleColor(UIColor.hex(hexString: "#8a8a8a"), for: .normal)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 5
        btn.layer.borderColor = UIColor.lightGray.cgColor
        btn.layer.borderWidth = 1
        btn.isEnabled = false
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn.contentEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5)
        return btn
    }()
    lazy var item_education:UIButton = {
        let btn = UIButton(type: .custom)
        btn .setTitleColor(UIColor.hex(hexString: "#8a8a8a"), for: .normal)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 5
        btn.layer.borderColor = UIColor.lightGray.cgColor
        btn.layer.borderWidth = 1
        btn.isEnabled = false
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn.contentEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5)
        return btn
    }()
    lazy var item_experience:UIButton = {
        let btn = UIButton(type: .custom)
        btn .setTitleColor(UIColor.hex(hexString: "#8a8a8a"), for: .normal)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 5
        btn.layer.borderColor = UIColor.lightGray.cgColor
        btn.layer.borderWidth = 1
        btn.isEnabled = false
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn.contentEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5)
        return btn
    }()
    lazy var item_sex:UIButton = {
        let btn = UIButton(type: .custom)
        btn .setTitleColor(UIColor.hex(hexString: "#8a8a8a"), for: .normal)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 5
        btn.layer.borderColor = UIColor.lightGray.cgColor
        btn.layer.borderWidth = 1
        btn.isEnabled = false
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn.contentEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5)
        return btn
    }()
    
    lazy var line:UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.groupTableViewBackground
        return v
    }()
    lazy var locationIcon:UIImageView = {
        let iv = UIImageView()
        iv.image  = UIImage(named: "item_location")
        return iv
    }()
    
    lazy var address:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.hex(hexString: "#8a8a8a")
        label.numberOfLines = 0
        return label
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func layoutviews() {
        contentView.addSubview(companyName)
        contentView.addSubview(compensation)
        contentView.addSubview(item_age)
        contentView.addSubview(item_education)
        contentView.addSubview(item_experience)
        contentView.addSubview(item_sex)
        contentView.addSubview(line)
        contentView.addSubview(locationIcon)
        contentView.addSubview(address)
        companyName.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(10)
        }
        compensation.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(companyName.snp.bottom).offset(10)
        }
        
        item_age.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(30)
            make.top.equalTo(compensation.snp.bottom).offset(10)
            make.width.lessThanOrEqualTo(100)
        }
        item_education.snp.makeConstraints { (make) in
            make.left.equalTo(item_age.snp.right).offset(10)
            make.top.equalTo(compensation.snp.bottom).offset(10)
            make.width.lessThanOrEqualTo(100)
        }
        item_experience.snp.makeConstraints { (make) in
            make.left.equalTo(item_education.snp.right).offset(10)
            make.top.equalTo(compensation.snp.bottom).offset(10)
            make.width.lessThanOrEqualTo(100)
        }
        item_sex.snp.makeConstraints { (make) in
            make.left.equalTo(item_experience.snp.right).offset(10)
//            make.right.equalToSuperview().offset(-30)
            make.top.equalTo(compensation.snp.bottom).offset(10)
            make.width.lessThanOrEqualTo(100)
        }
        
        line.snp.makeConstraints { (make) in
            make.top.equalTo(item_age.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        
        locationIcon.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.equalTo(line.snp.bottom).offset(15)
            make.width.height.equalTo(20)
        }
        
        address.snp.makeConstraints { (make) in
            make.centerY.equalTo(locationIcon)
            make.right.equalToSuperview().offset(-10)
            make.left.equalTo(locationIcon.snp.right).offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
        
    }
    
    var model:RecruitmentBrief? {
        didSet{
            guard let model = model else {
                return
            }
            companyName.text = model.title
            compensation.text = model.compensation
            item_age.setTitle(model.age, for: .normal)
            item_education.setTitle(model.education, for: .normal)
            item_experience.setTitle(model.experience, for: .normal)
            item_sex.setTitle(model.sex, for: .normal)
            address.text = model.address
            
        }
    }
}

class RecruitmentBrieMiddleCell: UITableViewCell {
    lazy var companyIntroductionTitle:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = "企业介绍"
        label.textColor = UIColor.hex(hexString: BasicColor)
        label.numberOfLines = 0
        return label
    }()
    lazy var companyName:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        return label
    }()
    lazy var line:UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.hex(hexString: BasicColor)
        return v
    }()
    
    lazy var logo:UIImageView = {
        let v = UIImageView()
        return v
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layoutviews() {
        contentView.addSubview(line)
        contentView.addSubview(companyIntroductionTitle)
        contentView.addSubview(logo)
        contentView.addSubview(companyName)
        line.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(10)
            make.width.equalTo(5)
            make.height.equalTo(20)
        }
        companyIntroductionTitle.snp.makeConstraints { (make) in
            make.centerY.equalTo(line)
            make.left.equalTo(line.snp.right).offset(10)
        }
        logo.snp.makeConstraints { (make) in
            make.top.equalTo(companyIntroductionTitle.snp.bottom).offset(10)
            make.height.equalTo(30)
            make.width.equalTo(60)
            make.left.equalTo(line)
            make.bottom.equalToSuperview().offset(-10)
        }
        companyName.snp.makeConstraints { (make) in
            make.left.equalTo(logo.snp.right).offset(10)
            make.centerY.equalTo(logo)
        }
    }
}

class RecruitmentBriefBottomCell: UITableViewCell {
    lazy var t1:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = "我能挣多少钱"
        label.textColor = UIColor.hex(hexString: BasicColor)
        label.numberOfLines = 0
        return label
    }()
    lazy var t2:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = "我需要做什么"
        label.textColor = UIColor.hex(hexString: BasicColor)
        label.numberOfLines = 0
        return label
    }()
    lazy var t3:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = "我能享受的福利待遇"
        label.textColor = UIColor.hex(hexString: BasicColor)
        label.numberOfLines = 0
        return label
    }()
    lazy var t4:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = "录用条件"
        label.textColor = UIColor.hex(hexString: BasicColor)
        label.numberOfLines = 0
        return label
    }()
    lazy var line1:UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.hex(hexString: BasicColor)
        return v
    }()
    lazy var line2:UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.hex(hexString: BasicColor)
        return v
    }()
    lazy var line3:UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.hex(hexString: BasicColor)
        return v
    }()
    lazy var line4:UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.hex(hexString: BasicColor)
        return v
    }()
    lazy var v1:UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.groupTableViewBackground
        return v
    }()
    lazy var v2:UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.groupTableViewBackground
        return v
    }()
    lazy var v3:UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.groupTableViewBackground
        return v
    }()
    lazy var t1_1:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.hex(hexString: "#8a8a8a")
        label.numberOfLines = 0
        return label
    }()
    lazy var t1_2:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.hex(hexString: "#8a8a8a")
        label.numberOfLines = 0
        return label
    }()
    lazy var t2_1:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.hex(hexString: "#8a8a8a")
        label.numberOfLines = 0
        return label
    }()
    lazy var t2_2:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.hex(hexString: "#8a8a8a")
        label.numberOfLines = 0
        return label
    }()
    lazy var t2_3:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.hex(hexString: "#8a8a8a")
        label.numberOfLines = 0
        return label
    }()
    lazy var t2_4:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.hex(hexString: "#8a8a8a")
        label.numberOfLines = 0
        return label
    }()
    lazy var t3_1:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.hex(hexString: "#8a8a8a")
        label.numberOfLines = 0
        return label
    }()
    lazy var t3_2:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.hex(hexString: "#8a8a8a")
        label.numberOfLines = 0
        return label
    }()
    lazy var t3_3:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.hex(hexString: "#8a8a8a")
        label.numberOfLines = 0
        return label
    }()
    lazy var t4_1:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.hex(hexString: "#8a8a8a")
        label.numberOfLines = 0
        return label
    }()
    lazy var t4_2:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.hex(hexString: "#8a8a8a")
        label.numberOfLines = 0
        return label
    }()
    lazy var t4_3:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.hex(hexString: "#8a8a8a")
        label.numberOfLines = 0
        return label
    }()
    lazy var t4_4:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.hex(hexString: "#8a8a8a")
        label.numberOfLines = 0
        return label
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func layoutviews() {
        contentView.addSubview(t1)
        contentView.addSubview(t2)
        contentView.addSubview(t3)
        contentView.addSubview(t4)
        contentView.addSubview(v1)
        contentView.addSubview(v2)
        contentView.addSubview(v3)
        contentView.addSubview(line1)
        contentView.addSubview(line2)
        contentView.addSubview(line3)
        contentView.addSubview(line4)
        contentView.addSubview(t1_1)
        contentView.addSubview(t1_2)
        contentView.addSubview(t2_1)
        contentView.addSubview(t2_2)
        contentView.addSubview(t2_3)
        contentView.addSubview(t2_4)
        contentView.addSubview(t3_1)
        contentView.addSubview(t3_2)
        contentView.addSubview(t3_3)
        contentView.addSubview(t4_1)
        contentView.addSubview(t4_2)
        contentView.addSubview(t4_3)
        contentView.addSubview(t4_4)
        
        line1.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(10)
            make.width.equalTo(5)
            make.height.equalTo(20)
        }
        t1.snp.makeConstraints { (make) in
            make.centerY.equalTo(line1)
            make.left.equalTo(line1.snp.right).offset(10)
        }
        t1_1.snp.makeConstraints { (make) in
            make.top.equalTo(t1.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
        }
        t1_2.snp.makeConstraints { (make) in
            make.top.equalTo(t1_1.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
        }
        v1.snp.makeConstraints { (make) in
            make.top.equalTo(t1_2.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        
        line2.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(v1.snp.bottom).offset(10)
            make.width.equalTo(5)
            make.height.equalTo(20)
        }
        t2.snp.makeConstraints { (make) in
            make.centerY.equalTo(line2)
            make.left.equalTo(line2.snp.right).offset(10)
        }
        t2_1.snp.makeConstraints { (make) in
            make.top.equalTo(t2.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
        }
        t2_2.snp.makeConstraints { (make) in
            make.top.equalTo(t2_1.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
        }
        t2_3.snp.makeConstraints { (make) in
            make.top.equalTo(t2_2.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
        }
        t2_4.snp.makeConstraints { (make) in
            make.top.equalTo(t2_3.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
        }
        v2.snp.makeConstraints { (make) in
            make.top.equalTo(t2_4.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        line3.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(v2.snp.bottom).offset(10)
            make.width.equalTo(5)
            make.height.equalTo(20)
        }
        t3.snp.makeConstraints { (make) in
            make.centerY.equalTo(line3)
            make.left.equalTo(line3.snp.right).offset(10)
        }
        t3_1.snp.makeConstraints { (make) in
            make.top.equalTo(t3.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
        }
        t3_2.snp.makeConstraints { (make) in
            make.top.equalTo(t3_1.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
        }
        t3_3.snp.makeConstraints { (make) in
            make.top.equalTo(t3_2.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
        }
        v3.snp.makeConstraints { (make) in
            make.top.equalTo(t3_3.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        line4.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(v3.snp.bottom).offset(10)
            make.width.equalTo(5)
            make.height.equalTo(20)
        }
        t4.snp.makeConstraints { (make) in
            make.centerY.equalTo(line4)
            make.left.equalTo(line2.snp.right).offset(10)
        }
        t4_1.snp.makeConstraints { (make) in
            make.top.equalTo(t4.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
        }
        t4_2.snp.makeConstraints { (make) in
            make.top.equalTo(t4_1.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
        }
        t4_3.snp.makeConstraints { (make) in
            make.top.equalTo(t4_2.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
        }
        t4_4.snp.makeConstraints { (make) in
            make.top.equalTo(t4_3.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.bottom.equalToSuperview().offset(-10)
        }
        
    }
    
    var model:RecruitmentBrief? {
        didSet{
            guard let model = model else {
                return
            }
            t1_1.text = "综合薪资：\(model.compensation ?? "")"
            t1_2.text = "基本薪资：\(model.base_salary ?? "")"
            t2_1.text = "工作内容：\(model.job_content ?? "")"
            t2_2.text = "工作时间：\(model.work_time ?? "")"
            t2_3.text = "发薪日：\(model.pay_time ?? "")"
            t2_4.text = "其他：\(model.other_work ?? "")"
            t3_1.text = "吃：\(model.eat ?? "")"
            t3_2.text = "住：\(model.live ?? "")"
            t3_3.text = "其他：\(model.other_welfare ?? "")"
            t4_1.text = "性别：\(model.sex ?? "")"
            t4_2.text = "年龄：\(model.age ?? "")"
            t4_3.text = "经验：\(model.experience ?? "")"
            t4_4.text = "其他：\(model.other_admit ?? "")"
        }
    }
}
