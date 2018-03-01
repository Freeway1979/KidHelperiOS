//
//  TextInputContrViewController.swift
//  KidHelper
//
//  Created by Liu PingAn on 28/02/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

import UIKit

class TextInputContrViewController: UIViewController {
    @IBOutlet weak var inputTextField: UITextField!
    
    typealias onTextChanged = (String) ->()
    
    var text:String? = nil
    
    var onTextChangedCallback:onTextChanged?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        inputTextField.text = text
    }


    @IBAction func onDoneClicked(_ sender: UIBarButtonItem) {
        let text = inputTextField.text
        if onTextChangedCallback != nil {
            onTextChangedCallback!(text!)
        }
        DataProvider.saveToiCloud(KeyConstant.MO_XIE.rawValue, text!)
        
        self.navigationController?.popViewController(animated: true)
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
