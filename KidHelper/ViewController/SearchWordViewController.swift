//
//  SearchWordViewController.swift
//  KidHelper
//
//  Created by Liu PingAn on 05/03/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

import UIKit

class SearchWordViewController: UIViewController {

    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initViews()
    }
 
    
    @IBAction func onSearchButtonClicked(_ sender: UIButton) {
        if let text = inputTextField.text {
            inputTextField.resignFirstResponder()
            let containsChinese = text.containChineseWords()
            if (containsChinese)
            {
                NetProvider.searchBaiduHanyu(text: text, webView: webView)
            }
            else
            {
                NetProvider.translateEnglish(text: text, webView: webView)
            }
        }
    }
    
    func initViews() {
        searchButton.setRoundStyle(borderColor: UIColor.clear)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
