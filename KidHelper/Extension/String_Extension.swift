//
//  String_Extension.swift
//  KidHelper
//
//  Created by Liu PingAn on 05/03/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

import UIKit

extension String {
    
    /// 是否包含中文
    ///
    /// - Parameter string: <#string description#>
    /// - Returns: <#return value description#>
    func containChineseWords() -> Bool {
        for (_, value) in self.enumerated() {
            if ("\u{4E00}" <= value  && value <= "\u{9FA5}") {
                return true
            }
        }
        return false
    }
}
