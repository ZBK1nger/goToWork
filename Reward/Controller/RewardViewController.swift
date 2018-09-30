//
//  RewardViewController.swift
//  goToWork
//
//  Created by 张博 on 2018/9/13.
//  Copyright © 2018年 Devin. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
class RewardViewController:BaseViewController {
    private var estimateRewardAmout:String?
    private var historyRewardAmount:String?
    //private var historyRewardList:HistoryRewardList? = HistoryRewardList()
    private var historyReward:[HistoryReward]? = [HistoryReward]()
    private lazy var rewardTableView:UITableView = {
        let tw = UITableView(frame: CGRect.zero, style: .plain)
        tw.delegate = self
        tw.dataSource = self
        tw.backgroundColor = UIColor.groupTableViewBackground
        tw.register(EstimateRewardTableViewCell.self, forCellReuseIdentifier: "EstimateRewardTableViewCell")
        tw.register(HistoryRewardListTableViewCell.self, forCellReuseIdentifier: "HistoryRewardListTableViewCell")
        tw.separatorStyle = UITableViewCellSeparatorStyle.none
        tw.tableFooterView = UIView()
        tw.estimatedRowHeight = 100;
        tw.rowHeight = UITableViewAutomaticDimension
        tw.uHead = URefreshHeader {[weak self] in self?.loadMoreData()}
        tw.uFoot = URefreshDiscoverFooter()
        //tw.uempty = UEmptyView { [weak self] in self?.loadData() }
        return tw
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "收入"
    }
    override func layoutViews() {
        view.addSubview(rewardTableView)
        rewardTableView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-TAB_BAR_HEIGHT)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadMoreData()
    }
    
    func loadMoreData() {
        guard let user_id = UserDefaults.standard.object(forKey: "user_id") else {
            return
        }
        ApiLoadingProvider.request(Api.reward(user_id: user_id as! String)) { (result) in
            switch result {
                case let .success(response):
                    self.rewardTableView.uHead.endRefreshing()
                do {
                    let json = try JSON(data: response.data)
                    self.estimateRewardAmout = json["d"].stringValue
                    self.historyRewardAmount = json["res"].stringValue
                    self.rewardTableView.reloadData()
                } catch {
                    
                }
                
                case let .failure(error):
                print(error)
            }
        }
        
        ApiRequest(Api.historyRewardList(user_id: user_id as! String), completion: { (response) -> (Void) in
            self.rewardTableView.uHead.endRefreshing()
            self.historyReward = HistoryRewardList.deserialize(from: response)?.res
            self.rewardTableView.reloadData()
        }) { (err) in
            print(err)
        }
    }
}

extension RewardViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else {
            return self.historyReward?.count ?? 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell:EstimateRewardTableViewCell = tableView.dequeueReusableCell(withIdentifier: "EstimateRewardTableViewCell", for: indexPath) as! EstimateRewardTableViewCell
            cell.amount = estimateRewardAmout
            cell.selectionStyle = .none
            return cell
        }
        else {
            let cell:HistoryRewardListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "HistoryRewardListTableViewCell", for: indexPath) as! HistoryRewardListTableViewCell
            cell.selectionStyle = .none
            cell.model = self.historyReward?[indexPath.row]
            return cell
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let headerView = UIView()
            headerView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 40)
            headerView.backgroundColor = UIColor.white
            
            let headerLine = UIView()
            headerLine.backgroundColor = UIColor.hex(hexString: BasicColor)
            
            
            let headerName = UILabel()
            headerName.font = UIFont.systemFont(ofSize: 15)
            headerName.text = "历史收入"
            
            let headerAmount = UILabel()
            headerAmount.font = UIFont.systemFont(ofSize: 15)
            headerAmount.text = "\(historyRewardAmount ?? "0")元"
            headerAmount.textColor = UIColor.hex(hexString: BasicColor)
            
            headerView.addSubview(headerLine)
            headerView.addSubview(headerName)
            headerView.addSubview(headerAmount)
            
            headerLine.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(5)
                make.bottom.equalToSuperview().offset(-5)
                make.left.equalToSuperview().offset(10)
                make.width.equalTo(5)
            }
            headerName.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.left.equalTo(headerLine.snp.right).offset(10)
                make.width.greaterThanOrEqualTo(60)
            }
            headerAmount.snp.makeConstraints { (make) in
                make.centerY.equalTo(headerName)
                make.right.equalToSuperview().offset(0)
                make.width.greaterThanOrEqualTo(60)
            }
            return headerView
        }
        else {
            return nil
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 40
    }
}
