//
//  ScheduleListTableViewCell.swift
//  goToWork
//
//  Created by 张博 on 2018/9/17.
//  Copyright © 2018年 Devin. All rights reserved.
//

import Foundation
import UIKit

class ScheduleListTableViewCell: UITableViewCell {
    private lazy var mettingDate:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.hex(hexString: "#8a8a8a")
        return label
    }()
    private lazy var commission:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .right
        label.textColor = UIColor.red
        return label
    }()
    private lazy var mettingAddress:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.hex(hexString: "#8a8a8a")
        return label
    }()
    private lazy var companyName:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.hex(hexString: "#8a8a8a")
        return label
    }()
    private lazy var  username:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.hex(hexString: "#8a8a8a")
        return label
    }()
    private lazy var  userTel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.hex(hexString: "#8a8a8a")
        return label
    }()
    private lazy var status_metting:UIButton = {
        let btn = UIButton(type: .custom)
        btn .setTitleColor(UIColor.hex(hexString: BasicColor), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.setTitle("面试通过", for: .normal)
        btn.setImage(UIImage(named: "status_true"), for: .normal)
        return btn
    }()
    private lazy var status_commission:UIButton = {
        let btn = UIButton(type: .custom)
        btn .setTitleColor(UIColor.hex(hexString: BasicColor), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.setTitle("满足佣金", for: .normal)
        btn.setImage(UIImage(named: "status_true"), for: .normal)
        return btn
    }()
    private lazy var status_end:UIButton = {
        let btn = UIButton(type: .custom)
        btn .setTitleColor(UIColor.hex(hexString: BasicColor), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.setTitle("确认结款", for: .normal)
        btn.setImage(UIImage(named: "status_true"), for: .normal)
        return btn
    }()
    private lazy var line1:UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.hex(hexString: BasicColor)
        return v
    }()
    private lazy var line2:UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.hex(hexString: BasicColor)
        return v
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor.white
        layoutViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layoutViews() {
        contentView.addSubview(mettingDate)
        contentView.addSubview(commission)
        contentView.addSubview(mettingAddress)
        contentView.addSubview(companyName)
        contentView.addSubview(username)
        contentView.addSubview(userTel)
        contentView.addSubview(status_metting)
        contentView.addSubview(status_commission)
        contentView.addSubview(status_end)
        contentView.addSubview(line1)
        contentView.addSubview(line2)
        mettingDate.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(10)
        }
        commission.snp.makeConstraints { (make) in
            make.left.equalTo(mettingDate.snp.right).offset(20)
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalTo(mettingDate)
        }
        mettingAddress.snp.makeConstraints { (make) in
            make.top.equalTo(mettingDate.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        companyName.snp.makeConstraints { (make) in
            make.top.equalTo(mettingAddress.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        username.snp.makeConstraints { (make) in
            make.top.equalTo(companyName.snp.bottom).offset(10)
            make.left.right.equalToSuperview().offset(10)
        }
        userTel.snp.makeConstraints { (make) in
            make.top.equalTo(username.snp.bottom).offset(10)
            make.left.right.equalToSuperview().offset(10)
        }
        status_metting.snp.makeConstraints { (make) in
             make.top.equalTo(userTel.snp.bottom).offset(10)
             make.left.equalToSuperview().offset(10)
             make.width.greaterThanOrEqualTo(60)
             make.height.greaterThanOrEqualTo(20)
             make.bottom.equalToSuperview().offset(-10)
        }
        line1.snp.makeConstraints { (make) in
            make.left.equalTo(status_metting.snp.right).offset(10)
            make.height.equalTo(1)
            make.centerY.equalTo(status_metting)
        }
        status_commission.snp.makeConstraints { (make) in
            make.left.equalTo(line1.snp.right).offset(10)
            make.centerX.equalToSuperview()
            make.width.greaterThanOrEqualTo(60)
            make.height.greaterThanOrEqualTo(10)
            make.centerY.equalTo(status_metting)
        }
        line2.snp.makeConstraints { (make) in
            make.left.equalTo(status_commission.snp.right).offset(10)
            make.height.equalTo(1)
            make.centerY.equalTo(status_metting)
        }
        status_end.snp.makeConstraints { (make) in
            make.left.equalTo(line2.snp.right).offset(10)
            make.right.equalToSuperview().offset(-10)
            make.width.greaterThanOrEqualTo(60)
            make.height.greaterThanOrEqualTo(20)
            make.centerY.equalTo(status_metting)
        }
    }
    var model:Schedule? {
        didSet{
            guard let model = model else {
                return
            }
            mettingDate.text = "面试时间：\(model.date ?? "")"
            commission.text = "佣金：\(model.premium ?? "")"
            mettingAddress.text = "面试地址：\(model.interview ?? "")"
            companyName.text = "面试公司：\(model.company_name ?? "")"
            username.text = "面试人：\(model.username ?? "")"
            userTel.text = "面试人电话：\(model.tel ?? "")"
            if model.status_mianshi == "1" {
                status_metting.setImage(UIImage.init(named: "status_true"), for: .normal)
            }
            else if model.status_mianshi == "3" {
                status_metting.setImage(UIImage(named: "status_false"), for: .normal)
            }
            else {
                status_metting.setImage(UIImage(named: "status_waiting"), for: .normal)
            }
            if model.status_yongjin == "1" {
                status_commission.setImage(UIImage.init(named: "status_true"), for: .normal)
            }
            else if model.status_yongjin == "3" {
                status_commission.setImage(UIImage(named: "status_false"), for: .normal)
            }
            else {
                status_commission.setImage(UIImage(named: "status_waiting"), for: .normal)
            }
            if model.status_jiekuan == "1" {
                status_end.setImage(UIImage.init(named: "status_true"), for: .normal)
            }
            else if model.status_jiekuan == "3" {
                status_end.setImage(UIImage(named: "status_false"), for: .normal)
            }
            else {
                status_end.setImage(UIImage(named: "status_waiting"), for: .normal)
            }
        }
    }
}
