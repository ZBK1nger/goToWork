//
//  RewardTableViewCell.swift
//  goToWork
//
//  Created by 张博 on 2018/9/26.
//  Copyright © 2018年 Devin. All rights reserved.
//

import Foundation
import UIKit

class EstimateRewardTableViewCell: UITableViewCell {
    lazy var bottomView:UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.groupTableViewBackground
        return v
    }()
    lazy var estimateRewardTitle:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor.hex(hexString: "#8a8a8a")
        label.text = "预计收入"
        label.numberOfLines = 0
        return label
    }()
    lazy var estimateRewardSubTitle:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.hex(hexString: BasicColor)
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "仅供参考，实际收入以企业确认为准"
        label.numberOfLines = 0
        return label
    }()
    
    lazy var estimateRewardAmount:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.hex(hexString: BasicColor)
        label.font = UIFont.systemFont(ofSize: 20)
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
        contentView.addSubview(estimateRewardTitle)
        contentView.addSubview(estimateRewardSubTitle)
        contentView.addSubview(estimateRewardAmount)
        contentView.addSubview(bottomView)
        estimateRewardTitle.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(15)
            make.width.greaterThanOrEqualTo(80)
        }
        estimateRewardSubTitle.snp.makeConstraints { (make) in
            make.left.equalTo(estimateRewardTitle.snp.right).offset(10)
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalTo(estimateRewardTitle)
        }
        estimateRewardAmount.snp.makeConstraints { (make) in
            make.top.equalTo(estimateRewardTitle.snp.bottom).offset(10)
            make.left.equalTo(estimateRewardTitle)
            make.width.greaterThanOrEqualTo(80)
        }
        bottomView.snp.makeConstraints { (make) in
            make.top.equalTo(estimateRewardAmount.snp.bottom).offset(15)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(10)
        }
    }
    
    var amount:String? {
        didSet{
            guard let amount = amount else {
                return
            }
            estimateRewardAmount.text = "\(amount)元"
        }
    }
    
}

class HistoryRewardListTableViewCell: UITableViewCell {
    lazy var backView:UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.white
        return v
    }()
    lazy var date:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.hex(hexString: "#8a8a8a")
        label.numberOfLines = 0
        return label
    }()
    lazy var company:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.hex(hexString: "#8a8a8a")
        label.numberOfLines = 0
        return label
    }()
    lazy var rewardAmount:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.hex(hexString: BasicColor)
        label.numberOfLines = 0
        label.textAlignment = .right
        return label
    }()
    lazy var name:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
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
        contentView.backgroundColor = UIColor.groupTableViewBackground
        contentView.addSubview(backView)
        backView.addSubview(date)
        backView.addSubview(company)
        backView.addSubview(rewardAmount)
        backView.addSubview(name)
        
        backView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(0)
        }
        
        rewardAmount.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.width.greaterThanOrEqualTo(100)
            make.right.equalToSuperview().offset(-10)
        }
        
        date.snp.makeConstraints { (make) in
            make.centerY.equalTo(rewardAmount)
            make.left.equalToSuperview().offset(10)
            make.right.equalTo(rewardAmount.snp.left).offset(-10)
        }
        company.snp.makeConstraints { (make) in
            make.top.equalTo(date.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        name.snp.makeConstraints { (make) in
            make.top.equalTo(company.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
        }
        
    }
    
    var model:HistoryReward? {
        didSet{
            guard let model = model else {
                return
            }
            date.text = "结款日期：\(model.date_interview ?? "")"
            rewardAmount.text = "金额：\(model.premium ?? "")"
            company.text = "雇主公司：\(model.company_name ?? "")"
            name.text = "应聘者：\(model.username ?? "")"
        }
    }
    
    
}
