//
//  LocationManager.swift
//  goToWork
//
//  Created by 张博 on 2018/9/18.
//  Copyright © 2018年 Devin. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class LocationManager:CLLocationManager, CLLocationManagerDelegate {
    
    private var successBlock: ((_ address: String) -> Void)?
    private var failBlock: ((_ error: String) -> Void)?
    
    override init() {
        super.init()
        self.delegate = self
        self.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    convenience init(getLocation success: @escaping (_ address: String) -> Void, failed: @escaping (_ error: String) -> Void) {
        self.init()
        self.getLocation(success: success, failed: failed)
    }
    
    func getLocation(success: @escaping (_ address: String) -> Void, failed: @escaping (_ error: String) -> Void) {
        self.successBlock = success
        self.failBlock = failed
        
        self.requestWhenInUseAuthorization()
        self.startUpdatingLocation()
    }
    
    // CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last {
            self.stopUpdatingLocation()
            let coor = location.coordinate
            let long = coor.longitude // 经度
            let lati = coor.latitude // 纬度
            print(long, lati)
            
            let geocoder = CLGeocoder.init()
            geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
                
                if let name = placemarks?.first?.locality {
                    if name.contains("市") {
                      self.successBlock?(name.replacingOccurrences(of: "市", with: ""))
                    }
                    else {
                        self.successBlock?(name)
                    }
                   
                } else {
                    self.failBlock?("抱歉，获取不到您的位置")
                }
                
                
            }
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.stopUpdatingLocation()
        var str = "未知错误"
        switch (error as NSError).code {
        case 0:
            str = "位置不可用"
            break
        case 1:
            str = "用户关闭"
            break
        default: break
        }
        print(str)
        self.failBlock?(str)
    }
    
}

