//
//  CollapsibleTableViewHeader.swift
//  goToWork
//
//  Created by 张博 on 2018/9/15.
//  Copyright © 2018年 Devin. All rights reserved.
//

import Foundation
import UIKit

protocol CollapsibleTableViewHeaderDelegate {
    func toggleSection(_ header: CollapsibleTableViewHeader, section: Int)
    func headerViewSelected(_ header: CollapsibleTableViewHeader,section: Int)
}

class CollapsibleTableViewHeader: UITableViewHeaderFooterView {
    
    var delegate: CollapsibleTableViewHeaderDelegate?
    var section: Int = 0
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        layoutViews()
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(CollapsibleTableViewHeader.tapHeader(_:))))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var name:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var fee:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .right
        label.textColor = UIColor.hex(hexString: BasicColor)
        return label
    }()
    lazy var category:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        label.textColor = UIColor.hex(hexString: "#8a8a8a")
        return label
    }()
    lazy var salary:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.textColor = UIColor.hex(hexString: "#ff6060")
        return label
    }()
    lazy var companyTag:UIButton = {
        let btn = UIButton(type: .custom)
        btn .setTitleColor(UIColor.hex(hexString: BasicColor), for: .normal)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 5
        btn.layer.borderColor = UIColor.lightGray.cgColor
        btn.layer.borderWidth = 1
        btn.isEnabled = false
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn.contentEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5)
        return btn
    }()
    lazy var makeMoney:UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("去赚钱", for: .normal)
        btn .setTitleColor(UIColor.hex(hexString: BasicColor), for: .normal)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 8
        btn.layer.borderColor = UIColor.hex(hexString: BasicColor).cgColor
        btn.layer.borderWidth = 1
        btn.contentEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5)
        return btn
    }()
    
    lazy var line:UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.hex(hexString: "#eaeaea")
        return v
    }()
    
    lazy var toggleBtn:UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "arrow_down"), for: .normal);
        btn.addTarget(self, action: #selector(CollapsibleTableViewHeader.toggle(_sender:)), for: .touchUpInside)
        return btn;
    }()
    
    
    func layoutViews() {
        contentView.backgroundColor = UIColor.white
        contentView.addSubview(fee)
        fee.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.width.greaterThanOrEqualTo(60)
        }
        contentView .addSubview(name)
        name.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalTo(fee.snp.left).offset(-20)
        }
        contentView.addSubview(category)
        category.snp.makeConstraints { (make) in
            make.top.equalTo(name.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-30)
        }
        contentView .addSubview(salary)
        salary.snp.makeConstraints { (make) in
            make.top.equalTo(category.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-30)
        }
        contentView .addSubview(makeMoney)
        makeMoney.snp.makeConstraints { (make) in
            make.top.equalTo(salary.snp.bottom).offset(10)
            make.right.equalToSuperview().offset(-10)
            make.width.equalTo(80)
        }
        contentView .addSubview(companyTag)
        companyTag.snp.makeConstraints { (make) in
            
            make.left.equalToSuperview().offset(10)
            make.centerY.equalTo(makeMoney)
            make.width.greaterThanOrEqualTo(60)
        }
        contentView.addSubview(toggleBtn)
        toggleBtn.snp.makeConstraints { (make) in
            make.top.equalTo(makeMoney.snp.bottom).offset(0)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(23)
        }
        
        contentView .addSubview(line)
        line.snp.makeConstraints { (make) in
            make.top.equalTo(toggleBtn.snp.bottom).offset(5)
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    @objc func toggle(_sender:UIButton) {
        
        delegate?.toggleSection(self, section: self.section)
    }
    
    @objc func tapHeader(_ gestureRecognizer: UITapGestureRecognizer) {
        guard let cell = gestureRecognizer.view as? CollapsibleTableViewHeader else {
            return
        }
        delegate?.headerViewSelected(self, section: cell.section)
    }
    
    func setCollapsed(_ collapsed: Bool) {
        collapsed ? toggleBtn.setImage(UIImage(named: "arrow_down"), for: .normal) : toggleBtn.setImage(UIImage(named: "arrow_up"), for: .normal)
    }
    
    var model:CompanyList? {
        didSet{
            guard let model = model else {
                return
            }
            name.text = model.company
            fee.text = "推荐费\(model.premium ?? "")"
            category.text = model.job
            salary.text = model.compensation
            companyTag.setTitle("免费班车", for: .normal)
            if(model.list != nil) {
                toggleBtn.isHidden = false
                line.snp.remakeConstraints { (make) in
                    make.top.equalTo(toggleBtn.snp.bottom).offset(5)
                    make.left.right.bottom.equalToSuperview()
                    make.height.equalTo(1)
                }
            }
            else {
                toggleBtn.isHidden = true
                line.snp.remakeConstraints { (make) in
                    make.top.equalTo(makeMoney.snp.bottom).offset(10)
                    make.left.right.bottom.equalToSuperview()
                    make.height.equalTo(1)
                }
                
            }
        }
    }
}
