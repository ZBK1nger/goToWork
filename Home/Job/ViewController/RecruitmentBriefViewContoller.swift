//
//  RecruitmentBriefViewContoller.swift
//  goToWork
//
//  Created by 张博 on 2018/9/29.
//  Copyright © 2018年 Devin. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import FSPagerView
class RecruitmentBriefViewContoller: BaseViewController {
    public var companyId:String?
    
    private var recruitmentBrief:RecruitmentBrief? = RecruitmentBrief()
    
    public var company:Company?
    
    private var imgs:[String]? = [String]()
    
    private var logo:String?
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
    
    private lazy var recruitmentBriefTableView:UITableView = {
        let tw = UITableView(frame: CGRect.zero, style: .plain)
        tw.delegate = self
        tw.dataSource = self
        tw.separatorStyle = UITableViewCellSeparatorStyle.none
        tw.tableFooterView = UIView()
        tw.register(RecruitmentBriefHeaderCell.self, forCellReuseIdentifier: "RecruitmentBriefHeaderCell")
        tw.register(RecruitmentBrieMiddleCell.self, forCellReuseIdentifier: "RecruitmentBrieMiddleCell")
        tw.register(RecruitmentBriefBottomCell.self, forCellReuseIdentifier: "RecruitmentBriefBottomCell")
        tw.estimatedRowHeight = 200
        tw.rowHeight = UITableViewAutomaticDimension
        tw.uHead = URefreshHeader {[weak self] in self?.loadData()}
        tw.uFoot = URefreshDiscoverFooter()
        //tw.uempty = UEmptyView { [weak self] in self?.loadData() }
        return tw
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "招聘简章"
        loadData()
    }
    
    override func layoutViews() {
        view.addSubview(entrollOthersBtn)
        view.addSubview(entrollSelfBtn)
        view.addSubview(recruitmentBriefTableView)
        
        entrollOthersBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.height.equalTo(49)
            make.width.equalTo(SCREEN_WIDTH  / 2 - 1)
            make.bottom.equalToSuperview().offset(-HOME_INDICATOR_HEIGHT)
        }
        
        entrollSelfBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.height.equalTo(49)
            make.width.equalTo(SCREEN_WIDTH  / 2 - 1)
            make.bottom.equalToSuperview().offset(-HOME_INDICATOR_HEIGHT)
            make.left.equalTo(entrollOthersBtn.snp.right).offset(1)
        }
        recruitmentBriefTableView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.bottom.equalTo(entrollSelfBtn.snp.top)
        }
    }
    
    func loadData() {
        ApiRequest(Api.recruitmentBrief(id: companyId ?? ""), completion: { (response) -> (Void) in
            self.recruitmentBriefTableView.uHead.endRefreshing()
            let json  = JSON(parseJSON: response)
            self.recruitmentBrief = RecruitmentBrief.deserialize(from: json["data"][0].dictionaryValue)
            self.logo = "https://www.beibeicare.com/hunter\(json["com_pic"][0]["path"].stringValue)"
            for img in json["img"].arrayObject as! [String]{
                self.imgs?.append("https://www.beibeicare.com/hunter\(img)")
            }
            self.recruitmentBriefTableView.reloadData()
            print(self.recruitmentBrief!)
        }) { (err) in
            print(err)
        }
    }
    
    
    
    // MARK - entroll for others
    @objc func entrollForOthers() {
        guard let user_id = UserDefaults.standard.object(forKey: "user_id") else {
            return
        }
        ApiRequest(Api.agentState(user_id: user_id as! String), completion: { (response) -> (Void) in
            let json = JSON(parseJSON: response)
            if json["data"]["status"].stringValue == "0" {
                UNoticeBar(config: UNoticeBarConfig(title: "请先注册经纪人")).show(duration: 2)
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
                UNoticeBar(config: UNoticeBarConfig(title:"不可重复报名")).show(duration: 2)
            }
        }) { (err) in
            print(err)
        }
    }
    
}

extension RecruitmentBriefViewContoller:UITableViewDelegate,UITableViewDataSource,FSPagerViewDelegate,FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.imgs?.count ?? 0
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        cell.imageView?.kf.setImage(with: URL(string: self.imgs?[index] ?? ""))
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell:RecruitmentBriefHeaderCell = tableView.dequeueReusableCell(withIdentifier: "RecruitmentBriefHeaderCell", for: indexPath) as! RecruitmentBriefHeaderCell
            cell.model = self.recruitmentBrief
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell:RecruitmentBrieMiddleCell = tableView.dequeueReusableCell(withIdentifier: "RecruitmentBrieMiddleCell", for: indexPath) as! RecruitmentBrieMiddleCell
            cell.logo.kf.setImage(with: URL(string: self.logo ?? ""))
            cell.companyName.text = self.company?.company
            cell.selectionStyle = .none
            return cell
        case 2:
            let cell:RecruitmentBriefBottomCell = tableView.dequeueReusableCell(withIdentifier: "RecruitmentBriefBottomCell", for: indexPath) as! RecruitmentBriefBottomCell
            cell.model = self.recruitmentBrief
            cell.selectionStyle = .none
            return cell
        default:
            let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            // Create a pager view
            let pagerView = FSPagerView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 150 * SCALE_Y))
            pagerView.backgroundColor = UIColor.groupTableViewBackground
            pagerView.dataSource = self
            pagerView.delegate = self
            pagerView.automaticSlidingInterval = 5
            pagerView.isInfinite = true
            pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            pagerView.itemSize = CGSize(width: SCREEN_WIDTH - 80, height: 120 * SCALE_Y)
            pagerView.transformer = FSPagerViewTransformer(type: .overlap)
            return pagerView
        }
        else if section == 1 {
            let header = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 10))
            header.backgroundColor = UIColor.groupTableViewBackground
            return header
        }
        else {
            let header = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 10))
            header.backgroundColor = UIColor.groupTableViewBackground
            return header
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 150 * SCALE_Y
        }
        else {
            return 10
        }
    }
}
