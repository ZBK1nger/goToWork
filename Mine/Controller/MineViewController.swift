//
//  MineViewController.swift
//  goToWork
//
//  Created by 张博 on 2018/9/13.
//  Copyright © 2018年 Devin. All rights reserved.
//

import Foundation
import UIKit
class MineViewController:BaseViewController {
    
    private var logosName = [["item_wallet","item_add","item_help"],["item_sever","item_advice","item_helper"],["item_about"]]
    
    private var itemsName = [["我的钱包","我要邀请","我的专属邀请码"],["客服","意见反馈","经纪人成就"],["关于我们"]]
    
    private lazy var mineTableView:UITableView = {
        let tw = UITableView(frame: CGRect.zero, style: .plain)
        tw.backgroundColor = UIColor.groupTableViewBackground
        tw.delegate = self
        tw.dataSource = self
        tw.register(MineHeaderTableViewCell.self, forCellReuseIdentifier: "MineHeaderTableViewCell")
        tw.register(MineListTableViewCell.self, forCellReuseIdentifier: "MineListTableViewCell")
        tw.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        tw.tableFooterView = UIView()
        return tw
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "个人"
    }
    
    override func layoutViews() {
        view.addSubview(mineTableView)
        mineTableView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-TAB_BAR_HEIGHT)
        }
    }
}
extension MineViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 3
        case 2:
            return 3
        case 3:
            return 1
        default:
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell:MineHeaderTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MineHeaderTableViewCell") as! MineHeaderTableViewCell
            cell.accessoryType = .disclosureIndicator
            return cell
        }
        else {
            let cell:MineListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MineListTableViewCell") as! MineListTableViewCell
            cell.logo.image = UIImage(named: logosName[indexPath.section - 1][indexPath.row])
            cell.itemName.text = itemsName[indexPath.section - 1][indexPath.row]
            cell.accessoryType = .disclosureIndicator
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 80
        }
        else {
            return 49
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 10))
        v.backgroundColor = UIColor.groupTableViewBackground
        return v
    }
}
