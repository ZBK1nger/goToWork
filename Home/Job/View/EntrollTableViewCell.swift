//
//  EntrollTableViewCell.swift
//  goToWork
//
//  Created by 张博 on 2018/9/27.
//  Copyright © 2018年 Devin. All rights reserved.
//

import Foundation
import UIKit
class EntrollTableViewHeader: UITableViewHeaderFooterView {
    lazy var backView:UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.white
        v.layer.masksToBounds = true
        v.layer.cornerRadius = 5
        return v
    }()
    lazy var company:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    lazy var fee:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.red
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var interView:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.hex(hexString: "#8a8a8a")
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        return label
    }()
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        layoutViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layoutViews() {
        contentView.backgroundColor = UIColor.groupTableViewBackground
        contentView.addSubview(backView)
        backView.addSubview(company)
        backView.addSubview(fee)
        backView.addSubview(interView)
        
        backView.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(15)
            make.right.bottom.equalToSuperview().offset(-15)
        }
        
        company.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        fee.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(company.snp.bottom).offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        interView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(fee.snp.bottom).offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    var model:Company? {
        didSet{
            guard  let model = model else {
                return
            }
            company.text = model.company
            fee.text = "推荐费：\(model.premium ?? "")"
            interView.text = "面试地址：\(model.interview ?? "")"
        }
    }
    
}
// MARK - EntrollDelegate
protocol EntrollDelegate {
    func submitEntrollInfo(name:String,tel:String,meetingDate:String,idCard:String)
}
class EntrollTableViewCell: UITableViewCell {
    var model:Company?
    let timeFormatter = DateFormatter()
    var delegate:EntrollDelegate?
    lazy var submit:UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = UIColor.hex(hexString: BasicColor)
        btn.setTitle("提交", for: .normal)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 5
        btn.setTitleColor(UIColor.white, for:.normal )
        btn.addTarget(self, action: #selector(self.entroll(_sender:)), for: .touchUpInside)
        return btn
    }()
    lazy var v1:UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.white
        return v
    }()
    lazy var v2:UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.white
        return v
    }()
    lazy var v3:UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.white
        return v
    }()
    lazy var v4:UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.white
        return v
    }()
    lazy var name:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text  = "姓名*"
        return label
    }()
    
    lazy var phone:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text  = "手机号*"
        return label
    }()
    
    lazy var meetingDate:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text  = "面试时间*"
        return label
    }()
    
    lazy var idCardTitle:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.hex(hexString: "#8a8a8a")
        label.backgroundColor = UIColor.groupTableViewBackground
        label.text  = "身份证信息仅用于面试时使用，请放心填写"
        return label
    }()
    
    lazy var idCard:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text  = "身份证号"
        return label
    }()
    
    lazy var tf_name:UITextField = {
        let textField = UITextField()
        // 背景颜色
        textField.backgroundColor = UIColor.white
        textField.textAlignment = .right
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textColor = UIColor.hex(hexString: "#8a8a8a")
        // 边框样式
        textField.borderStyle = UITextBorderStyle.none
        // 提示语
        textField.placeholder = "请输入姓名"
        // 键盘样式
        textField.keyboardType = UIKeyboardType.default
        
        return textField
    }()
    lazy var tf_phone:UITextField = {
        let textField = UITextField()
        // 背景颜色
        textField.backgroundColor = UIColor.white
        textField.textAlignment = .right
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textColor = UIColor.hex(hexString: "#8a8a8a")
        // 边框样式
        textField.borderStyle = UITextBorderStyle.none
        // 提示语
        textField.placeholder = "请输入手机号"
        // 键盘样式
        textField.keyboardType = UIKeyboardType.phonePad
        
        return textField
    }()
    lazy var tf_idcard:UITextField = {
        let textField = UITextField()
        // 背景颜色
        textField.backgroundColor = UIColor.white
        textField.textAlignment = .right
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textColor = UIColor.hex(hexString: "#8a8a8a")
        // 边框样式
        textField.borderStyle = UITextBorderStyle.none
        // 提示语
        textField.placeholder = "请输入身份证号"
        // 键盘样式
        textField.keyboardType = UIKeyboardType.phonePad
        
        return textField
    }()
    lazy var tf_meetingDate:UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = UIColor.white
        timeFormatter.dateFormat = "yyyy-MM-dd"
        let time = timeFormatter.string(from: Date())
        btn.setTitle("\(time)", for: .normal)
        btn.setTitleColor(UIColor.hex(hexString: "#8a8a8a"), for:.normal )
        btn.titleLabel?.textAlignment = .right
        btn.addTarget(self, action: #selector(self.popDatePicker), for: .touchUpInside)
        return btn
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        tf_phone.resignFirstResponder()
        tf_name.resignFirstResponder()
        tf_meetingDate.resignFirstResponder()
        tf_idcard.resignFirstResponder()
    }
    // MARK - 弹出面试开始时间和结束时间的时间选择器
    @objc func popDatePicker() {
        let dateFormatter = "yyyy-MM-dd"
        let datePicker = DatePickerView.datePicker(style: .yearMonthDay, scrollToDate: Date()) { date in
            guard let date = date else { return }
            
            let dateStr = date.toString("yyyy-MM-dd")
            self.tf_meetingDate.setTitle(dateStr, for: .normal)
        }
        
        let date = Date.date(self.tf_meetingDate.currentTitle!, formatter: dateFormatter)
        
        if let date = Date.date((self.model?.start?.timeIntervalChangeToTimeStr(dateFormat: "yyyy-MM-dd") ?? "\(timeFormatter.string(from: Date()))"), formatter: dateFormatter) {
            datePicker.minLimitDate = date
        }
        
        if let date = Date.date((self.model?.end?.timeIntervalChangeToTimeStr(dateFormat: "yyyy-MM-dd") ?? "\(timeFormatter.string(from: Date()))"), formatter: dateFormatter) {
            datePicker.maxLimitDate = date
        }
        
        datePicker.scrollToDate = date == nil ? Date() : date!
        
        datePicker.show()
        
    }
    
    //提交报名信息
    @objc func entroll(_sender:UIButton) {
        if delegate != nil {
            delegate?.submitEntrollInfo(name: tf_name.text ?? "", tel: tf_phone.text ?? "", meetingDate: tf_meetingDate.titleLabel?.text ?? "", idCard: tf_idcard.text ?? "")
        }
    }
    
  
    func layoutViews() {
        contentView.backgroundColor = UIColor.groupTableViewBackground
        contentView.addSubview(v1)
        contentView.addSubview(v2)
        contentView.addSubview(v3)
        contentView.addSubview(v4)
        contentView.addSubview(idCardTitle)
        v1.addSubview(name)
        v1.addSubview(tf_name)
        v2.addSubview(phone)
        v2.addSubview(tf_phone)
        v3.addSubview(meetingDate)
        v3.addSubview(tf_meetingDate)
        v4.addSubview(idCard)
        v4.addSubview(tf_idcard)
        contentView.addSubview(submit)
        
        v1.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(49)
        }
        
        name.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.width.greaterThanOrEqualTo(60)
        }
        tf_name.snp.makeConstraints { (make) in
            make.left.equalTo(name.snp.right).offset(10)
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalTo(name)
        }
        
        v2.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(49)
            make.top.equalTo(v1.snp.bottom).offset(1)
        }
        
        phone.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.width.greaterThanOrEqualTo(60)
        }
        tf_phone.snp.makeConstraints { (make) in
            make.left.equalTo(phone.snp.right).offset(10)
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalTo(phone)
        }
        
        v3.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(49)
            make.top.equalTo(v2.snp.bottom).offset(1)
        }
        
        meetingDate.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.width.greaterThanOrEqualTo(80)
        }
        tf_meetingDate.snp.makeConstraints { (make) in
            make.left.equalTo(meetingDate.snp.right).offset(10)
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalTo(meetingDate)
        }
        idCardTitle.snp.makeConstraints { (make) in
            make.top.equalTo(v3.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview()
        }
        
        v4.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(49)
            make.top.equalTo(idCardTitle.snp.bottom).offset(10)
        }
        
        idCard.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.width.greaterThanOrEqualTo(60)
        }
        tf_idcard.snp.makeConstraints { (make) in
            make.left.equalTo(idCard.snp.right).offset(10)
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalTo(idCard)
        }
        
        submit.snp.makeConstraints { (make) in
            make.top.equalTo(v4.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(49)
            make.width.equalTo(160)
        }
        
    }
    
}
