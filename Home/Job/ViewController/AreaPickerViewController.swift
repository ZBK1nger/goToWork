//
//  AreaPickerViewController.swift
//  goToWork
//
//  Created by 张博 on 2018/9/25.
//  Copyright © 2018年 Devin. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

protocol modifySelectedCityProtocol {
   func  modifySelectedCity(city:String)
}
class AreaPickerViewController: BaseViewController {
    
    private var cityList = [String]()
    
    var currentCity:String?
    
    var delegate:modifySelectedCityProtocol?
    
    //使用懒加载方式来创建UITableView
    lazy var tableView: UITableView = {
        let tempTableView = UITableView (frame: self.view.bounds, style: UITableViewStyle.plain)
        tempTableView.delegate = self
        tempTableView.dataSource = self
        tempTableView.tableFooterView = UIView.init()
        tempTableView.estimatedRowHeight = 40
        tempTableView.rowHeight = UITableViewAutomaticDimension
        return tempTableView
    }()
    
    //使用懒加载方式来创建UISearchBar
    lazy var searchBar: UISearchBar = {
        let tempSearchBar = UISearchBar()
        tempSearchBar.backgroundColor = UIColor.white
        tempSearchBar.placeholder = "请输入您要搜索的城市";
        tempSearchBar.showsCancelButton = false;
        tempSearchBar.delegate = self
        tempSearchBar.searchBarStyle = .minimal
        return tempSearchBar
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "城市"
        loadData()
    }
    
    func loadData() {
//        ApiRequest(Api.cityList, completion: { (response) -> (Void) in
//            let json = JSON(response)
//            print(json)
//            //print(json["title"].stringValue)
//
//            let title = json["title"].stringValue
//            print(title)
//        }) { (error) in
//            print(error)
//        }
        ApiLoadingProvider.request(Api.cityList) { (result) in
            switch result {
            case let .success(response):
                do {
                    let json = try JSON(data: response.data)
                    print(json["title"].stringValue)
                    let cityArray = json["item"].array
                    for item in cityArray ?? [] {
                        self.cityList.append(item["name"].stringValue)
                    }
                    self.tableView.reloadData()
                } catch {
                    
                }
                
            case let .failure(error):
                print(error)
            }
        }
    }
    override func layoutViews() {
        view.addSubview(searchBar)
        view.addSubview(tableView)
        searchBar.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(40)
        }
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(searchBar.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-TAB_BAR_HEIGHT)
        }
    }
}

extension AreaPickerViewController:UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else {
            return cityList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "cellId"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
        }
        if indexPath.section == 0 {
            cell?.textLabel?.text = currentCity
            cell?.textLabel?.textColor = UIColor.hex(hexString: BasicColor)
        }
        else {
            cell?.textLabel?.text = cityList[indexPath.row]
        }
        return cell!
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.groupTableViewBackground
        headerView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 40)
        
        let label = UILabel()
        label.textColor = UIColor.hex(hexString: "#8a8a8a")
        label.font = UIFont.boldSystemFont(ofSize: 18)
        headerView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.width.greaterThanOrEqualTo(80)
        }
        if section == 0 {
            label.text = "我的位置"
        }
        else {
            label.text = "已开通城市"
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if (delegate != nil){
                delegate?.modifySelectedCity(city: currentCity ?? "")
            }
        }
        else  {
            if(delegate != nil) {
                delegate?.modifySelectedCity(city: self.cityList[indexPath.row])
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
    
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        isSearch = false
//        searchBar.resignFirstResponder()
//        tableView.reloadData()
//    }
//
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        for cityString in self.cityList {
            if cityString == searchBar.text  {
                self.cityList.removeAll()
                self.cityList.append(cityString)
            }
            else {
                UNoticeBar(config: UNoticeBarConfig(title: "该城市暂未开通")).show(duration: 2)
            }
        }
        tableView.reloadData()
        //filterBySubstring(filterStr: searchBar.text! as NSString)
    }
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        filterBySubstring(filterStr: searchText as NSString)
//    }
    
}
