//
//  ScheduleListViewController.swift
//  goToWork
//
//  Created by 张博 on 2018/9/17.
//  Copyright © 2018年 Devin. All rights reserved.
//

import Foundation
import UIKit
class ScheduleListViewController: BaseViewController {
    private var schedule:[Schedule]? = [Schedule]()
    private lazy var scheduleListTableView : UITableView  = {
        let tw = UITableView(frame: CGRect.zero, style: .plain)
        tw.backgroundColor = UIColor.groupTableViewBackground
        tw.delegate = self
        tw.dataSource = self
        tw.register(ScheduleListTableViewCell.self, forCellReuseIdentifier: "ScheduleListTableViewCell")
        tw.separatorStyle = UITableViewCellSeparatorStyle.none
        tw.tableFooterView = UIView()
        tw.estimatedRowHeight = 200;
        tw.rowHeight = UITableViewAutomaticDimension
        tw.uHead = URefreshHeader {[weak self] in self?.loadMoreData()}
        tw.uFoot = URefreshDiscoverFooter()
        tw.uempty = UEmptyView { [weak self] in self?.loadMoreData() }
        //tw.uempty?.allowShow = true
        // 希望footer高为0
        return tw
    }()
    
    override func layoutViews() {
        view.addSubview(scheduleListTableView)
        scheduleListTableView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-TAB_BAR_HEIGHT)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMoreData()
    }
    
    // MARK 加载数据
    private func loadMoreData() {
        //oA5Pi5KnaMPBQM9b0_RI9coLFVPw
        guard let user_id = UserDefaults.standard.object(forKey: "user_id") else {
            return
        }
        ApiRequest(Api.scheduleList(user_id: user_id as! String), completion: { (response) -> (Void) in
            self.scheduleListTableView.uHead.endRefreshing()
            self.scheduleListTableView.uempty?.allowShow = true
            self.schedule = ScheduleList.deserialize(from: response)?.company 
            self.scheduleListTableView.reloadData()
        }) { (error) in
            print(error)
        }
    }
}
extension ScheduleListViewController:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ScheduleListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ScheduleListTableViewCell", for: indexPath) as! ScheduleListTableViewCell
        cell.model = schedule?[indexPath.section]
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return schedule?.count ?? 0
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 10))
        return view
    }
    
}
