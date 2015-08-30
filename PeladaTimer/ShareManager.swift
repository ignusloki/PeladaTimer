//
//  ShareManager.swift
//  PeladaTimer
//
//  Created by Felipe on 23/08/2015.
//  Copyright (c) 2015 fastman. All rights reserved.
//

import Foundation


class SharingManager {
    class var sharedInstance: SharingManager {
        struct Static {
            static var instance: SharingManager?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = SharingManager()
        }
        
        return Static.instance!
    }
    
    var timeMax : Int!
    var timeAlarm : Int!
    
}