//
//  EntrollViewController.swift
//  goToWork
//
//  Created by 张博 on 2018/9/27.
//  Copyright © 2018年 Devin. All rights reserved.
//

import Foundation
import UIKit
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
