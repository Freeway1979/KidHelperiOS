//
//  HomeViewController.swift
//  KidHelper
//
//  Created by Liu PingAn on 28/02/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

import UIKit
import AVFoundation
import Reachability
import Alamofire

extension UIButton {
    func setRoundStyle(borderColor:UIColor = UIColor.gray,borderWidth:CGFloat=2,cornerRadius:CGFloat = 6) -> Void {
        self.layer.borderColor = borderColor.cgColor ;
        self.layer.borderWidth = CGFloat(borderWidth);
        self.layer.cornerRadius = CGFloat(cornerRadius);
    }
}

class HomeViewController: UIViewController,AVSpeechSynthesizerDelegate,WXSpeechSynthesizerDelegate,WXSpeechSynthesizerPlayerDelegate {
    
    

    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var playLastButton: UIButton!
    
    @IBOutlet weak var repeatButton: UIButton!
    
    var speechManager:SpeechManager = SpeechManager.shared
    
    var textToPlay:String = ""
    var startTime:Date? = nil
    var position:Int = 0
    {
        willSet
        {
            print("Will set an new value \(newValue) to position")
        }
        didSet {
            print("position changed from \(oldValue) to \(position)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        speechManager.initSpeechEngine(delegate:self)
        
        initViews()
        
    }
 
    override func viewDidAppear(_ animated: Bool) {
        if let moxie = DataProvider.readFromiCloud(KeyConstant.MO_XIE.rawValue) {
            let saved = UserDefaults.standard.string(forKey: KeyConstant.MO_XIE.rawValue)
            if (saved != moxie)
            {
                UserDefaults.standard.set(moxie, forKey: KeyConstant.MO_XIE.rawValue)
                UserDefaults.standard.set(nil, forKey: KeyConstant.MO_XIE_PROGRESS.rawValue)
                let dicList = moxie.split(separator: " ")
                let count = dicList.count as Int!
                UserDefaults.standard.set(count, forKey: KeyConstant.MO_XIE_COUNT.rawValue)
            }
        }
    }
    
    deinit {
        speechManager.releaseResource()
    }
    

    func initViews() -> Void {
        self.position = UserDefaults.standard.integer(forKey: KeyConstant.MO_XIE_PROGRESS.rawValue)
        let count = UserDefaults.standard.integer(forKey: KeyConstant.MO_XIE_COUNT.rawValue)
        let enabled = self.position < count
        playLastButton.isEnabled = enabled
        repeatButton.isEnabled = enabled
        
        playLastButton.setRoundStyle(borderColor: UIColor.clear)
        repeatButton.setRoundStyle(borderColor: UIColor.clear)
        playButton.setRoundStyle(borderColor: UIColor.clear)
    }

    func checkNetwork() -> Bool {
        let isReachable = NetworkReachabilityManager()?.isReachable
        if !isReachable! {
            UIUtils.showWarningMessage("警告", subtitle:"当前网络不可用，请检查你的网络")
            return false
        }
        return true
    }
    
    @IBAction func onPlayLastButtonClicked(_ sender: UIButton) {
        if checkNetwork() == false {
            return
        }
        self.position = self.position - 1
        if (self.position < 0)
        {
            self.position = 0
        }
        _ = playText()
    }
    
    @IBAction func onRepeatButtonClicked(_ sender: UIButton) {
        if checkNetwork() == false {
            return
        }
        _ = playText()
    }
    
    @IBAction func onPlayButtonClicked(_ sender: UIButton) {
        if checkNetwork() == false {
            return
        }
        sender.isEnabled = false
        if (startTime == nil)
        {
            startTime = Date()
        }
        self.position = UserDefaults.standard.integer(forKey: KeyConstant.MO_XIE_PROGRESS.rawValue)
        if (self.position==0) {
            startTime = Date()
        }
        _ = playText()
         sender.isEnabled = true
    }
    func playText() -> Int {
        let result:(text:String?,count:Int?) = getPlayText(of: self.position)
        var text:String! = result.text
        if (text==nil) {
            UIUtils.showWarningMessage("警告",subtitle: "没有设置听写内容，请在设置中添加")
            return 0
        }
        if (text == "已听写完毕") {
            let seconds = calculateTime()
            text = "已听写完毕 耗时 \(seconds)"
            playTextAndSavePosition(text, 0)
            playButton.setTitle("开始听写", for: .normal)
            playLastButton.isEnabled = false
            repeatButton.isEnabled = false
            return 0
        }
        playLastButton.isEnabled = true
        repeatButton.isEnabled = true
        playTextAndSavePosition(text, self.position+1)
        let leftCount = result.count! - self.position - 1
        playButton.setTitle("下一个 (\(leftCount))", for: .normal)
        return leftCount
    }
    func getPlayText(of position:Int) -> (String?,Int?) {
        let textAll =  UserDefaults.standard.string(forKey: KeyConstant.MO_XIE.rawValue)
        if textAll == nil {
            return (nil,0)
        }
        
        let dicList = textAll!.split(separator: " ")
        let count = dicList.count as Int!
        if position >= count! {
            return ("已听写完毕",count)
        }
        let o = dicList[position]
        var text:String! = nil
        text = String(describing: o) as String!
        return (text,count)
    }
    func calculateTime( ) -> String {
        let endTime = Date()
        var seconds = Int(endTime.timeIntervalSince1970-(startTime?.timeIntervalSince1970)!)
        let minutes = seconds / 60
        seconds = seconds % 60
        return "\(minutes)分\(seconds)秒"
    }
    func playTextAndSavePosition(_ text:String!,_ position:Int) -> Void {
        print(text,position)
        
        SpeechManager.shared.playTTS(with: NSLocalizedString(text!, comment: ""))
        
        UserDefaults.standard.set(position, forKey: KeyConstant.MO_XIE_PROGRESS.rawValue)
    }
    //WXSpeechSynthesizerPlayerDelegate
    func playerDidFinishPlaying() {
        
    }
    
    func playerError() {
         
    }
    //------------------------------------------------------
    //WXSpeechSynthesizerDelegate
    //------------------------------------------------------
    func speechSynthesizerResultSpeechData(_ speechData: Data!, speechFormat: Int32) {
        let player = WXSpeechManager.shared.player
        player.playNewData(speechData)
    }
    func speechSynthesizerMakeError(_ error: Int) {
        
    }
    func speechSynthesizerDidCancel() {
        
    }
    
}

