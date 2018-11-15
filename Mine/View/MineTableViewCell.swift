//
//  MineTableViewCell.swift
//  goToWork
//
//  Created by 张博 on 2018/10/9.
//  Copyright © 2018年 Devin. All rights reserved.
//

import Foundation
import UIKit
class MineHeaderTableViewCell: UITableViewCell {
    
    lazy var iconImageView:UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = UIColor.red
        iv.layer.masksToBounds = true
        iv.layer.cornerRadius = 20
        return iv
    }()
    
    private lazy var nickName:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Devin"
        label.textColor = UIColor.hex(hexString: "#8a8a8a")
        return label
    }()
    
    private lazy var agentCategory:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "个人经纪人"
        label.textColor = UIColor.hex(hexString: "#8a8a8a")
        return label
    }()
    
    private lazy var agentStatus:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "点击注册"
        label.textColor = UIColor.hex(hexString: "#8a8a8a")
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutViews() {
        contentView.addSubview(nickName)
        contentView.addSubview(agentCategory)
        contentView.addSubview(agentStatus)
        contentView.addSubview(iconImageView)
        
        iconImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(49)
        }
        
        nickName.snp.makeConstraints { (make) in
            make.left.equalTo(iconImageView.snp.right).offset(10)
            make.top.equalToSuperview().offset(20)
        }
        
        agentCategory.snp.makeConstraints { (make) in
            make.top.equalTo(nickName.snp.bottom).offset(10)
            make.left.equalTo(nickName)
        }
        
        agentStatus.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
        }
    }
}

class MineListTableViewCell: UITableViewCell {
    lazy var logo:UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = UIColor.clear
        return iv
    }()
    
     lazy var itemName:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = "Devin"
        label.textColor = UIColor.hex(hexString: "#8a8a8a")
        return label
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutViews() {
        contentView.addSubview(logo)
        contentView.addSubview(itemName)
        logo.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.width.height.equalTo(25)
        }
        itemName.snp.makeConstraints { (make) in
            make.left.equalTo(logo.snp.right).offset(12)
            make.centerY.equalToSuperview()
        }
    }
    
}
