//
//  JobDetailViewController.swift
//  goToWork
//
//  Created by 张博 on 2018/9/19.
//  Copyright © 2018年 Devin. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import SwiftMessages
class JobDetailViewController: BaseViewController {
    
    public var companyId:String?
    
    private var company:Company? = Company()
    
    private lazy var recruitmentBriefBtn:UIButton = {
        let btn = UIButton(type:.custom)
        btn.backgroundColor = UIColor.white
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.setTitleColor(UIColor.black, for:.normal)
        btn.setTitle("招聘简章", for: .normal)
        btn.addTarget(self, action: #selector(pushRecruitmentBriefPage), for: .touchUpInside)
        return btn
    }()
    
    private lazy var line:UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.groupTableViewBackground
        return v
    }()
    private lazy var shareBtn:UIButton = {
        let btn = UIButton(type:.custom)
        btn.backgroundColor = UIColor.white
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.setTitleColor(UIColor.black, for:.normal)
        btn.setTitle("分享邀请", for: .normal)
        btn.addTarget(self, action: #selector(shareJobLinks), for: .touchUpInside)
        return btn
    }()
    private lazy var entrollOthersBtn:UIButton = {
        let btn = UIButton(type:.custom)
        btn.backgroundColor = UIColor.hex(hexString: BasicColor)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.setTitleColor(UIColor.white, for:.normal)
        btn.setTitle("帮TA报名", for: .normal)
        btn.addTarget(self, action: #selector(entrollForOthers), for: .touchUpInside)
        return btn
    }()
    private lazy var entrollSelfBtn:UIButton = {
        let btn = UIButton(type:.custom)
        btn.backgroundColor = UIColor.hex(hexString: BasicColor)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.setTitleColor(UIColor.white, for:.normal)
        btn.setTitle("我要报名", for: .normal)
        btn.addTarget(self, action: #selector(entrollForSelf), for: .touchUpInside)
        return btn
    }()
    
    private lazy var jobDetailTableView:UITableView = {
        let tw = UITableView(frame: CGRect.zero, style: .plain)
        tw.delegate = self
        tw.dataSource = self
        tw.register(CommissionPolicyCell.self, forCellReuseIdentifier: "CommissionPolicyCell")
        tw.register(JobDescriptionCell.self, forCellReuseIdentifier: "JobDescriptionCell")
        tw.register(CommissionIntroductionCell.self, forCellReuseIdentifier: "CommissionIntroductionCell")
        tw.separatorStyle = UITableViewCellSeparatorStyle.none
        tw.tableFooterView = UIView()
        tw.estimatedRowHeight = 200;
        tw.rowHeight = UITableViewAutomaticDimension
        tw.uHead = URefreshHeader {[weak self] in self?.loadMoreData()}
        tw.uFoot = URefreshDiscoverFooter()
        //tw.uempty = UEmptyView { [weak self] in self?.loadData() }
        return tw
    }()
    
    //MARK - HeaderView
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.title = "职位详情"
        print(companyId ?? "0")
        loadMoreData()
    }
    
    override func layoutViews() {
        view.addSubview(recruitmentBriefBtn)
        view.addSubview(shareBtn)
        view.addSubview(entrollOthersBtn)
        view.addSubview(entrollSelfBtn)
        view.addSubview(jobDetailTableView)
        view.addSubview(line)
        
        recruitmentBriefBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.height.equalTo(49)
            make.width.equalTo(80)
            make.bottom.equalToSuperview().offset(-HOME_INDICATOR_HEIGHT)
        }
        line.snp.makeConstraints { (make) in
            make.left.equalTo(recruitmentBriefBtn.snp.right)
            make.width.equalTo(1)
            make.top.equalTo(recruitmentBriefBtn.snp.top).offset(10)
            make.bottom.equalTo(recruitmentBriefBtn.snp.bottom).offset(10)
            make.right.equalTo(shareBtn.snp.left)
        }
        shareBtn.snp.makeConstraints { (make) in
            make.left.equalTo(line.snp.right).offset(0)
            make.height.equalTo(49)
            make.width.equalTo(recruitmentBriefBtn)
            make.bottom.equalToSuperview().offset(-HOME_INDICATOR_HEIGHT)
        }
        entrollOthersBtn.snp.makeConstraints { (make) in
            make.left.equalTo(shareBtn.snp.right).offset(0)
            make.height.equalTo(49)
            make.width.equalTo((SCREEN_WIDTH - 80 * 2 - 2) / 2)
            make.bottom.equalToSuperview().offset(-HOME_INDICATOR_HEIGHT)
        }
        entrollSelfBtn.snp.makeConstraints { (make) in
            make.left.equalTo(entrollOthersBtn.snp.right).offset(1)
            make.right.equalToSuperview()
            make.height.equalTo(49)
            make.width.equalTo(entrollOthersBtn)
            make.bottom.equalToSuperview().offset(-HOME_INDICATOR_HEIGHT)
        }
        jobDetailTableView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.bottom.equalTo(recruitmentBriefBtn.snp.top)
        }
    }
    
    private func loadMoreData() {
        ApiRequest(Api.jobDetail(company_id: companyId ?? ""), completion: { (response) -> (Void) in
            self.jobDetailTableView.uHead.endRefreshing()
            self.company = Company.deserialize(from: response)
            self.jobDetailTableView.reloadData()
        }) { (error) in
            print(error)
        }
    }
    
    //MARK - push recruitment Brief page
    @objc func pushRecruitmentBriefPage() {
        let recruitmentBriefViewController = RecruitmentBriefViewContoller()
        recruitmentBriefViewController.companyId = self.companyId
        recruitmentBriefViewController.company = self.company
        navigationController?.pushViewController(recruitmentBriefViewController, animated: true)
    }
    //MARK - share Links for others
    @objc func shareJobLinks() {
        SwiftMessageViewConfig.show(type: .error, title: "暂不能分享邀请", body: "")
    }
    // MARK - entroll for others
    @objc func entrollForOthers() {
        guard let user_id = UserDefaults.standard.object(forKey: "user_id") else {
            return
        }
        ApiRequest(Api.agentState(user_id: user_id as! String), completion: { (response) -> (Void) in
            let json = JSON(parseJSON: response)
            if json["data"]["status"].stringValue == "0" {
                SwiftMessageViewConfig.show(type: .error, title: "请先注册经纪人", body: "")
            }
            else {
                let entrollViewController = EntrollViewController()
                entrollViewController.navTitle = "帮TA报名"
                entrollViewController.company  = self.company
                self.navigationController?.pushViewController(entrollViewController, animated: true)
            }
        }) { (err) in
            print(err)
        }
    }
    // MARK - entroll for self
    @objc func entrollForSelf() {
        guard let user_id = UserDefaults.standard.object(forKey: "user_id") else {
            return
        }
        ApiRequest(Api.entrollForSelfState(user_id: user_id as! String), completion: { (response) -> (Void) in
            let json = JSON(parseJSON: response)
            if json["res"].stringValue == "1" {
                let entrollViewController = EntrollViewController()
                entrollViewController.navTitle = "我要报名"
                entrollViewController.company  = self.company
                self.navigationController?.pushViewController(entrollViewController, animated: true)
            }
            else {
                SwiftMessageViewConfig.show(type: .error, title: "不可重复报名", body: "")
            }
        }) { (err) in
            print(err)
        }
    }
}
extension JobDetailViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell:CommissionPolicyCell = tableView.dequeueReusableCell(withIdentifier: "CommissionPolicyCell", for: indexPath) as! CommissionPolicyCell
            cell.model = self.company
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell:JobDescriptionCell = tableView.dequeueReusableCell(withIdentifier: "JobDescriptionCell", for: indexPath) as! JobDescriptionCell
            cell.model = self.company
            cell.selectionStyle = .none
            return cell
        case 2:
            let cell:CommissionIntroductionCell = tableView.dequeueReusableCell(withIdentifier: "CommissionIntroductionCell", for: indexPath) as! CommissionIntroductionCell
            cell.model = self.company
            cell.selectionStyle = .none
            return cell
        default:
            let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 30)
        headerView.backgroundColor = UIColor.groupTableViewBackground
        
        let headerLine = UIView()
        headerLine.backgroundColor = UIColor.hex(hexString: BasicColor)
        
        let headerName = UILabel()
        headerName.font = UIFont.systemFont(ofSize: 15)
        
        headerView.addSubview(headerLine)
        headerView.addSubview(headerName)
        
        headerLine.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(5)
        }
        headerName.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(headerLine.snp.right).offset(10)
        }
        if section == 0 {
            headerName.text = "佣金政策"
        }
        else if section == 1 {
            headerName.text = "招聘说明"
        }
        else {
            headerName.text = "佣金说明"
        }
        return headerView
    }
    
    
}


