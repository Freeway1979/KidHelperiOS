//
//  DataProvider.swift
//  KidHelper
//
//  Created by Liu PingAn on 28/02/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

import UIKit

class DataProvider: NSObject {
    static var iCloudKeyStore: NSUbiquitousKeyValueStore! = NSUbiquitousKeyValueStore()
   
    class func saveToiCloud(_ key:String,_ text:String) {
        iCloudKeyStore?.set(text,forKey:key)
        iCloudKeyStore?.synchronize()
    }
    
    class func readFromiCloud(_ key :String) -> String?
    {
        return iCloudKeyStore?.string(forKey: key)
    }
}
