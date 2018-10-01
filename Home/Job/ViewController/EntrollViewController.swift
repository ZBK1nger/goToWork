//
//  EntrollViewController.swift
//  goToWork
//
//  Created by 张博 on 2018/9/27.
//  Copyright © 2018年 Devin. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
class EntrollViewController: BaseViewController {
    public var company:Company?
    public var navTitle:String?
    lazy var entrollTableView:UITableView = {
        let tw = UITableView(frame: CGRect.zero, style: .plain)
        tw.delegate = self
        tw.dataSource = self
        tw.backgroundColor = UIColor.groupTableViewBackground
        tw.register(EntrollTableViewCell.self, forCellReuseIdentifier: "EntrollTableViewCell")
        tw.separatorStyle = UITableViewCellSeparatorStyle.none
        tw.tableFooterView = UIView()
        tw.estimatedRowHeight = 200;
        tw.rowHeight = UITableViewAutomaticDimension
        tw.estimatedSectionHeaderHeight = 120;
        tw.sectionHeaderHeight = UITableViewAutomaticDimension;
        //tw.uHead = URefreshHeader {[weak self] in self?.getCompanyListFromSever()}
        tw.uFoot = URefreshDiscoverFooter()
        return tw
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = navTitle
    }
    override func layoutViews() {
        view.addSubview(entrollTableView)
        entrollTableView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-HOME_INDICATOR_HEIGHT)
        }
    }
    
}
extension EntrollViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:EntrollTableViewCell = tableView.dequeueReusableCell(withIdentifier: "EntrollTableViewCell", for: indexPath) as! EntrollTableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.model = self.company
        cell.delegate = self
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header:EntrollTableViewHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "EntrollTableViewHeader") as? EntrollTableViewHeader ?? EntrollTableViewHeader(reuseIdentifier: "EntrollTableViewHeader")
        header.model = self.company
        return header
    }
    
}
extension EntrollViewController:EntrollDelegate {
    func submitEntrollInfo(name: String, tel: String, meetingDate: String, idCard: String) {
        if name.isEmpty || tel.isEmpty {
            SwiftMessageViewConfig.show(type: .error, title: "姓名或者电话不能为空", body: "")
        }
        else if tel.count != 11 {
            SwiftMessageViewConfig.show(type: .error, title: "手机号长度有误", body: "")
        }
        else if !tel.verifyText(type: .PhoneNumber) {
            SwiftMessageViewConfig.show(type: .error, title: "请检查手机号码正确性", body: "")
        }
        else if !idCard.verifyText(type: .IdentityCard) && !idCard.isEmpty {
            SwiftMessageViewConfig.show(type: .error, title: "请检查身份证正确性", body: "")
        }
        else if meetingDate.isEmpty {
            SwiftMessageViewConfig.show(type: .error, title: "请选择面试时间", body: "")
        }
        else {
            guard let user_id = UserDefaults.standard.object(forKey: "user_id") else {
                return
            }
            if navTitle == "帮TA报名" {
                ApiRequest(Api.entrollForOthers(id: (self.company?.id)!, id_card: idCard, user_id: user_id as!String, username: name, tel: tel, date: meetingDate), completion: { (response) -> (Void) in
                    let json = JSON(parseJSON: response)
                    print(json)
                    if json["date"] == "1" {
                        self.sendMessage(name: name, date: meetingDate, tel: tel)
                    }
                    else if json["date"] == "3" {
                        SwiftMessageViewConfig.show(type: .error, title: "不可重复报名", body: "")
                    }
                    else {
                        SwiftMessageViewConfig.show(type: .error, title: "报名失败", body: "")
                    }
                }) { (err) in
                    print(err)
                }
            }
            else {
                ApiRequest(Api.entrollForSelf(id: self.company?.id ?? "", id_card: idCard, user_id: user_id as! String, username: name, tel: tel, date: meetingDate), completion: { (response) -> (Void) in
                    let json = JSON(parseJSON: response)
                    print(json)
                    if json["date"] == "1" {
                        self.sendMessage(name: name, date: meetingDate, tel: tel)
                    }
                    else if json["date"] == "3" {
                        SwiftMessageViewConfig.show(type: .error, title: "不可重复报名", body: "")                        
                    }
                    else {
                        SwiftMessageViewConfig.show(type: .error, title: "报名失败", body: "")
                    }
                }) { (err) in
                    print(err)
                }
            }
        }
    }
    
    func sendMessage(name:String,date:String,tel:String) {
        
        let content = "尊敬的\(name)您好！您已预约\(company?.company ?? "")|\(company?.job ?? "")的职位！请于\(date)之前到\(company?.interview ?? "")参加面试！如有问题请联系客服0512-87819866"
        ApiRequest(Api.sendEntrollMessage(tel: tel, content: content), completion: { (response) -> (Void) in
            let json = JSON(parseJSON: response)
            print(json)
            if json["res"] == JSON.null {
                SwiftMessageViewConfig.show(type: .success, title: "报名成功,请注意查收短信", body: "")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                    self.navigationController?.popViewController(animated: true)
                })
            }
            else {
                SwiftMessageViewConfig.show(type: .success, title: "报名成功,短信验证码发送失败", body: "")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                    self.navigationController?.popViewController(animated: true)
                })
            }
        }) { (err) in
            print(err)
        }
    }
    
}
