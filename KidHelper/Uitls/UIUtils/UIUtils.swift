//
//  UIUtils.swift
//  KidHelper
//
//  Created by Liu PingAn on 05/03/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

import UIKit

class UIUtils {
    class func showMessage(_ title:String,subtitle:String)
    {
        _ = SweetAlert().showAlert(title, subTitle: subtitle, style: AlertStyle.none)
    }
    class func showWarningMessage(_ title:String,subtitle:String)
    {
        _ = SweetAlert().showAlert(title, subTitle: subtitle, style: AlertStyle.warning)
    }
    class func showErrorMessage(_ title:String,subtitle:String)
    {
        _ = SweetAlert().showAlert(title, subTitle: subtitle, style: AlertStyle.error)
    }
    class func showSuccessMessage(_ title:String,subtitle:String)
    {
        _ = SweetAlert().showAlert(title, subTitle: subtitle, style: AlertStyle.success)
    }
    class func showLoading()
    {
        SVProgressHUD.show()
    }
    class func showLoading(text:String?)
    {
        SVProgressHUD.show(withStatus: text)
    }
    class func showError(text:String?)
    {
        SVProgressHUD.showError(withStatus: text)
    }
    class func showSuccess(text:String?)
    {
        SVProgressHUD.showSuccess(withStatus: text)
    }
    class func showInfo(text:String?)
    {
        SVProgressHUD.showInfo(withStatus: text)
    }
    class func dismissLoading(delay:TimeInterval = 0)
    {
        if (delay == 0) {
          SVProgressHUD.dismiss()
        }
        else
        {
           SVProgressHUD.dismiss(withDelay: delay)
        }
    }
}
