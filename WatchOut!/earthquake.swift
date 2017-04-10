//
//  earthquake.swift
//  WatchOut!
//
//  Created by Derek Wu on 2017/4/9.
//  Copyright © 2017年 Xintong Wu. All rights reserved.
//

import Foundation
import CoreLocation


class earthquake{
    var lattitude: Double?
    var longitude: Double?
    var loc : CLLocation?
    var radius: Double?
    var user_count = 0
    var user_dict = [String:[String]]()//dict for [user id:[String of user info]] pair
    var TIV_count = 0
    var Premium_count = 0
    var Building_limit_count = 0
    var count = 0
    
    init(lattitude: Double, longitude: Double, radius: Double){
        self.lattitude = lattitude
        self.longitude = longitude
        self.radius = radius
        self.loc = CLLocation(latitude: lattitude, longitude: longitude)
        
        for individual in user_info{
            //print(individual[0])
            var ind = individual[0].components(separatedBy: ",")

            var user_loc = CLLocation(latitude: Double(ind[5])!, longitude: Double(ind[6])!)
            let distanceInMeters = self.loc?.distance(from: user_loc)
            print(Double(distanceInMeters!))
            if (Double(distanceInMeters!) <= self.radius! * 1609.0){
                user_dict[ind[0]] = individual
                count = count + 1
            }
            self.TIV_count = self.TIV_count + (ind[2] as NSString).integerValue
            self.Premium_count = self.Premium_count + (ind[1] as NSString).integerValue
            self.Building_limit_count = self.Building_limit_count + Int(ind[3])!
        }
        print(self.TIV_count ?? -1)
        
    }
}
