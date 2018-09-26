//
//  JobListViewController.swift
//  goToWork
//
//  Created by 张博 on 2018/9/13.
//  Copyright © 2018年 Devin. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import Then
import HandyJSON
import McPicker
class JobListViewController:BaseViewController {
    
    var manager: LocationManager = LocationManager.init()
    
    private var companyList = [CompanyList]()
    
    private var position:[Position]? = [Position]()
    //重新拼成的职位列表
    private var list = [String]()
    
    private var data: [[String]] = [[String]]()
    
    private var cityName:String = "苏州"
    
    private var positionName:String = "不限"
    
    // 省市区
    var myProvince: String?
    
    var myCity: String?
    
    var myArea: String?
    
    private lazy var cityBtn:UIButton = {
        let btn = UIButton(type:.custom)
        btn.backgroundColor = UIColor.hex(hexString: BasicColor)
        btn.setImage(UIImage(named: "arrow_white"), for: .normal)
        btn.setTitleColor(UIColor.white, for:.normal)
        btn.addTarget(self, action: #selector(popCityList), for: .touchUpInside)
        return btn
    }()
    
    private lazy var positionBtn = UIButton().then { (btn) in
        btn.backgroundColor = UIColor.hex(hexString: BasicColor)
        btn.setTitleColor(UIColor.white, for:.normal )
        btn.setImage(UIImage(named: "arrow_white"), for: .normal)
        btn.setTitle("不限", for: .normal)
        btn.setImagePosition(position: .right, spacing: 0)
        btn.addTarget(self, action: #selector(self.popPositionList), for: .touchUpInside)
    }
    lazy var companyListTableView:UITableView = {
        let tw = UITableView(frame: CGRect.zero, style: .plain)
        tw.delegate = self
        tw.dataSource = self
        tw.register(CompanyListTableViewCell.self, forCellReuseIdentifier: "CompanyListTableViewCell")
        tw.separatorStyle = UITableViewCellSeparatorStyle.none
        tw.tableFooterView = UIView()
        tw.estimatedRowHeight = 200;
        tw.rowHeight = UITableViewAutomaticDimension
        tw.estimatedSectionHeaderHeight = 200;
        tw.sectionHeaderHeight = UITableViewAutomaticDimension;
        tw.uHead = URefreshHeader {[weak self] in self?.getCompanyListFromSever()}
        tw.uFoot = URefreshDiscoverFooter()
        //tw.uempty = UEmptyView { [weak self] in self?.loadData() }
        // 希望footer高为0
//        tw.estimatedSectionFooterHeight = 0;
//        tw.sectionFooterHeight = 0;
        
        return tw
    }()
    
    
    private lazy var noviceNoteBtn: UIButton = {
        let sn = UIButton(type: .custom)
        sn.setTitleColor(UIColor.black, for: .normal)
        sn.setImage(UIImage(named: "novice_note"), for: .normal)
        sn.addTarget(self, action: #selector(showNoviceNote), for: .touchUpInside)
        return sn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //loadData()
        getLocation()
    }
    //MARK - 定位
    private func getLocation() {
        manager.getLocation(success: { (city) in
            self.cityBtn.setTitle(city, for: .normal)
            self.cityBtn.setImagePosition(position: .right, spacing: 0)
            self.cityName = city
            self.getPositionListFromSever()
        }) { (error) in
            print(error)
        }
    }
    //MARK - 获取公司列表
    private func getCompanyListFromSever() {
        ApiRequest(.joblist(address: self.cityName, job: self.positionName), completion: { (response) -> (Void) in
            self.companyListTableView.uHead.endRefreshing()
            //self.companyListTableView.uempty?.allowShow = true
            self.companyList = [CompanyList].deserialize(from: response)! as! [CompanyList]
            self.companyListTableView.reloadData()
        }) { (error) in
            print(error)
        }
        
    }
   //MARK -获取职位列表
    private func getPositionListFromSever() {
        ApiRequest(.jobCategoryList, completion: { (response) -> (Void) in
            self.position = PositionList.deserialize(from: response)?.data
            if self.position != nil {
                for item in self.position! {
                    self.list.append(item.name!)
                    self.data.removeAll()
                    self.data.append(self.list)
                }
                self.getCompanyListFromSever()
            }
            
        }) { (error) in
            print(error)
        }
    }
    
    // MARK - 弹出职位列表
    @objc func popPositionList() {
        McPicker.show(data: data, doneHandler: { [weak self] (selections: [Int:String]) in
            if let name = selections[0] {
                    self?.positionBtn.setTitle(name, for: .normal)
                    self?.positionBtn.setImagePosition(position: .right, spacing: 0)
                    self?.positionName = name
                self?.getCompanyListFromSever()
            }
            }, cancelHandler: {
                print("Canceled Default Picker")
        }, selectionChangedHandler: { (selections: [Int:String], componentThatChanged: Int) in
            let newSelection = selections[componentThatChanged] ?? "Failed to get new selection!"
            print("Component \(componentThatChanged) changed value to \(newSelection)")
        })
    }
    
    //MARK - 弹出城市选择器
    @objc func popCityList() {
        let areaPickViewController = AreaPickerViewController()
        //noviceNoteWebViewController.hidesBottomBarWhenPushed = true
        if let navigationController = navigationController {
            navigationController.pushViewController(areaPickViewController, animated: true)
            areaPickViewController.currentCity = cityBtn.titleLabel?.text
            areaPickViewController.delegate = self
            return
        }
        present(areaPickViewController, animated: true, completion: nil)
    }
    
// MARK - 跳转到新手须知页面
    @objc private func showNoviceNote() {
        let noviceNoteWebViewController = NoviceNoteWebViewController()
        //noviceNoteWebViewController.hidesBottomBarWhenPushed = true
        if let navigationController = navigationController {
            navigationController.pushViewController(noviceNoteWebViewController, animated: true)
            return
        }
        present(noviceNoteWebViewController, animated: true, completion: nil)
    }
    
    override func layoutViews() {
        view.addSubview(cityBtn)
        cityBtn.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(1)
            make.left.equalToSuperview()
            make.size.equalTo(CGSize(width: SCREEN_WIDTH / 2 - 0.5, height: 49))
        }
        
        view.addSubview(positionBtn)
        positionBtn.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(1)
            make.right.equalToSuperview()
            make.size.equalTo(CGSize(width: SCREEN_WIDTH / 2 - 0.5, height: 49))
        }
        view.addSubview(companyListTableView)
        companyListTableView.snp.makeConstraints { (make) in
            make.top.equalTo(cityBtn.snp.bottom).offset(1)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-TAB_BAR_HEIGHT)
        }
        view.addSubview(noviceNoteBtn)
        noviceNoteBtn.snp.makeConstraints {
            $0.width.height.equalTo(40)
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().offset(-10)
        }
    }
    
}
extension JobListViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if companyList[section].list == nil {
            return 0
        }
        return companyList[section].collapsed! ? 0 : (companyList[section].list?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:CompanyListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CompanyListTableViewCell", for: indexPath) as! CompanyListTableViewCell
            cell.subModel = (companyList[indexPath.section].list?[indexPath.row])!
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return companyList.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? CollapsibleTableViewHeader ?? CollapsibleTableViewHeader(reuseIdentifier: "header")
        header.model = companyList[section]
        header.setCollapsed(companyList[section].collapsed!)
        header.delegate = self
        header.section = section
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // 当collapsed为true时 所有cell的高度设置为0 为收起状态 反之依然
        return companyList[indexPath.section].collapsed! ? 0 : UITableViewAutomaticDimension
    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return UITableViewAutomaticDimension
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let jobDetailViewController = JobDetailViewController()
        if let navgationController = navigationController {
            jobDetailViewController.companyId = companyList[indexPath.section].list?[indexPath.row].id
            navgationController.pushViewController(jobDetailViewController, animated: true)
            return
        }
        navigationController?.present(jobDetailViewController, animated: true, completion: nil)
    }

}

//
// MARK: - Section Header Delegate
//
extension JobListViewController: CollapsibleTableViewHeaderDelegate,modifySelectedCityProtocol {
    //MARK - modifySelectedCityProtocol
    func modifySelectedCity(city: String) {
        self.cityBtn.setTitle(city, for: .normal)
        self.cityBtn.setImagePosition(position: .right, spacing: 0)
        self.cityName = city
        self.getPositionListFromSever()
    }
    
    // 通过改变model中collapsed的状态来进行展开收起
    func toggleSection(_ header: CollapsibleTableViewHeader, section: Int) {
        let collapsed = !companyList[section].collapsed!
        
        // Toggle collapse
        companyList[section].collapsed! = collapsed
        header.setCollapsed(collapsed)
        
        UIView.performWithoutAnimation {
             companyListTableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
        }
    }
    
    func headerViewSelected(_ header: CollapsibleTableViewHeader, section: Int) {
        let jobDetailViewController = JobDetailViewController()
        if let navgationController = navigationController {
            jobDetailViewController.companyId = companyList[section].id
            navgationController.pushViewController(jobDetailViewController, animated: true)
            return
        }
        navigationController?.present(jobDetailViewController, animated: true, completion: nil)
    }
    
}

