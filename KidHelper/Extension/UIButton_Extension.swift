//
//  UIButton_Extension.swift
//  KidHelper
//
//  Created by Liu PingAn on 05/03/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

import UIKit

extension UIButton {
    func setRoundStyle(borderColor:UIColor = UIColor.gray,borderWidth:CGFloat=2,cornerRadius:CGFloat = 6) -> Void {
        self.layer.borderColor = borderColor.cgColor ;
        self.layer.borderWidth = CGFloat(borderWidth);
        self.layer.cornerRadius = CGFloat(cornerRadius);
    }
}
