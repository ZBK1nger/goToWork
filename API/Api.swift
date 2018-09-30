//
//  Api.swift
//  goToWork
//
//  Created by 张博 on 2018/9/13.
//  Copyright © 2018年 Devin. All rights reserved.
//

import Foundation
import Moya
import SwiftProgressHUD
import Alamofire
/// 超时时长
private var requestTimeOut:Double = 30
///成功数据的回调
typealias successCallback = ((String) -> (Void))
///失败的回调
typealias failedCallback = ((String) -> (Void))
///网络错误的回调
typealias errorCallback = (() -> (Void))

func ApiRequest(_ target: Api, completion: @escaping successCallback , failure:@escaping (MoyaError)->()) {
    //先判断网络是否有链接 没有的话直接返回--代码略
    if !isNetworkConnect{
        print("提示用户网络似乎出现了问题")
        return
    }
    ApiLoadingProvider.request(target) { (result) in
        //隐藏hud
        switch result {
        case let .success(response):
            completion(String(data: response.data, encoding: String.Encoding.utf8)!)
            //                if jsonData[RESULT_CODE].stringValue == "1000"{
            //                    completion(String(data: response.data, encoding: String.Encoding.utf8)!)
            //                }else{
            //                if failed != nil{
            //                    failed(String(data: response.data, encoding: String.Encoding.utf8)!)
            //                }
            //                }

        case let .failure(error):
            failure(error)
        }
    }
}


/// 基于Alamofire,网络是否连接，，这个方法不建议放到这个类中,可以放在全局的工具类中判断网络链接情况
/// 用get方法是因为这样才会在获取isNetworkConnect时实时判断网络链接请求，如有更好的方法可以fork
var isNetworkConnect: Bool {
    get{
        let network = NetworkReachabilityManager()
        return network?.isReachable ?? true //无返回就默认网络已连接
    }
}

// MARK - 设置插件
//private let networkPlugin = NetworkActivityPlugin.init { (changeType, targetType) in
//
//    print("networkPlugin \(changeType)")
//    //targetType 是当前请求的基本信息
//    switch(changeType){
//    case .began:
//        print("开始请求网络")
//
//    case .ended:
//        print("结束")
//    }
//}

private let LoadingPlugin = NetworkActivityPlugin { (type, target) in
    guard let vc = window else { return }
    switch type {
    case .began:
        SwiftProgressHUD.hideAllHUD()
        SwiftProgressHUD.showWait()
    case .ended:
        SwiftProgressHUD.hideAllHUD()
    }
}
//MARK: - 设置请求头部信息
//let myEndpointClosure = { (target: Api) -> Endpoint<Api> in
//
//
//    let url = target.baseURL.appendingPathComponent(target.path).absoluteString
//    let endpoint = Endpoint<Api>(
//        url: url,
//        sampleResponseClosure: { .networkResponse(200, target.sampleData) },
//        method: target.method,
//        task: target.task,
//        httpHeaderFields: target.headers
//    )
//
//    //在这里设置你的HTTP头部信息
//    return endpoint.adding(newHTTPHeaderFields: [
//        "Content-Type" : "application/x-www-form-urlencoded",
//        "ECP-COOKIE" : ""
//        ])
//
//}
// MARK: - 设置请求超时时间
private let requestClosure = {(endpoint: Endpoint, done: MoyaProvider.RequestResultClosure) in
    do {
        var request = try endpoint.urlRequest()
        //设置请求时长
        request.timeoutInterval = 30
        // 打印请求参数
        if let requestData = request.httpBody {
            print("\(request.url!)"+"\n"+"\(request.httpMethod ?? "")" + "\n" + "发送参数"+"\(String(data: request.httpBody!, encoding: String.Encoding.utf8) ?? "")")
        }else{
            print("\(request.url!)"+"\(String(describing: request.httpMethod))")
        }
        done(.success(request))
    } catch {
        done(.failure(MoyaError.underlying(error, nil)))
    }
}


let ApiProvider = MoyaProvider<Api>(requestClosure: requestClosure)
let ApiLoadingProvider = MoyaProvider<Api>(requestClosure: requestClosure, plugins: [LoadingPlugin])
//let ApiLoadingProvider = MoyaProvider<Api>(requestClosure: requestClosure)

enum Api {
    case jobCategoryList // 首页职位列表
    case joblist(address:String , job:String) // 首页招聘列表
    case scheduleList(user_id:String) //面试日程列表
    case jobDetail(company_id:String) //职位详情
    case entrollForSelfState(user_id:String) //判断自己给自己报名的状态
    case agentState(user_id:String)
    /*
      获取经纪人状态
    - 1未注册（在该处加入短信验证，提交手机号验证成功后默认该步完成）
    - 2已注册待完善（在该处加入短信提醒功能，您在上班呗经纪人注册信息已通过等等）
    - 3已注册已完善待审核
    - 4已注册已完善审核通过
 */
    case cityList //获取已开通城市列表
    case historyRewardList(user_id:String) // 历史收入列表
    case reward(user_id:String) //预计收入和历史收入
    case entrollForOthers(id:String,id_card:String,user_id:String,username:String,tel:String,date:String) //经纪人为求职者报名
    case entrollForSelf(id:String,id_card:String,user_id:String,username:String,tel:String,date:String) //经纪人（或者为游客）为自己报名
    case sendEntrollMessage(tel:String,content:String) // 报名成功后发送短信验证码
    case recruitmentBrief(id:String)
}

extension Api:TargetType {
    var baseURL: URL {
        return URL(string: "https://www.beibeicare.com")!
    }
    
    var path: String {
        switch self {
        case .jobCategoryList:
            return "/hunter/index.php/Home/XiangQing/job"
        case .joblist:
            return "/hunter/index.php/Home/Api/getListbyCompany"
        case .scheduleList:
            return "/hunter/index.php/Home/Personal/interview"
        case .jobDetail:
            return "/hunter/index.php/Home/XiangQing/demand"
        case .entrollForSelfState:
            return "/hunter/index.php/Home/Personal/baoming_zhuangtai"
        case .agentState:
            return "/hunter/index.php/Home/Api/getInfobyid"
        case .cityList:
            return "/hunter/index.php/Home/Api/getCityList"
        case .historyRewardList:
            return "/hunter/index.php/Home/Personal/premium"
        case .reward:
            return  "/hunter/index.php/Home/Personal/plan_premium"
        case .entrollForOthers:
            return "/hunter/index.php/Home/Personal/schedule"
        case .entrollForSelf:
            return "/hunter/index.php/Home/Personal/schedule_geren"
        case .sendEntrollMessage:
            return "/hunter/sendms"
        case .recruitmentBrief:
            return "/hunter/index.php/Home/XiangQing/demand_details"
        }
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        var params: [String: Any] = [:]
        switch self {
        case .joblist(let address, let job):
            params["address"] = address
            params["job"] = job
        case .scheduleList(let user_id):
            params["user_id"] = user_id
        case .jobDetail(let company_id):
            params["id"] = company_id
        case .entrollForSelfState(let user_id):
            params["user_id"] = user_id
        case .agentState(let user_id):
            params["user_id"] = user_id
        case .historyRewardList(let user_id):
            params["user_id"] = user_id
        case .reward(let user_id):
            params["user_id"] = user_id
        case .entrollForOthers(let id, let id_card, let user_id, let user_name, let tel, let date):
            params["id"] = id
            params["id_card"] = id_card
            params["user_id"] = user_id
            params["username"] = user_name
            params["tel"] = tel
            params["date"] = date
        case .entrollForSelf(let id, let id_card, let user_id, let user_name, let tel, let date):
            params["id"] = id
            params["id_card"] = id_card
            params["user_id"] = user_id
            params["username"] = user_name
            params["tel"] = tel
            params["date"] = date
        case .sendEntrollMessage(let tel, let content):
            params["tel"] = tel
            params["content"] = content
        case .recruitmentBrief(let id):
            params["id"] = id
        default:
            return.requestPlain
        }
        return .requestParameters(parameters: params, encoding: URLEncoding.default)
    }
    
    var headers: [String : String]? {
        return ["Content-Type":"application/x-www-form-urlencoded"]
    }
    
}

