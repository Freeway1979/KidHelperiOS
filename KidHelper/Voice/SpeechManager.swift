//
//  SpeechManager.swift
//  KidHelper
//
//  Created by Liu PingAn on 04/03/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

import UIKit

class SpeechManager: NSObject {
    public static let shared = SpeechManager()

    enum SpeechSDKProvider:String {
        case APPLE = "Apple"
        case QQ = "QQ"
    }
    
    var sdkProvider:SpeechSDKProvider = .QQ
    
    func initSpeechEngine(delegate:WXSpeechSynthesizerDelegate,volumn:Float = 1.0) {
        if sdkProvider == .QQ {
            WXSpeechManager.shared.initSpeechEngine(delegate: delegate,playerDelegate:delegate as! WXSpeechSynthesizerPlayerDelegate,volumn: volumn)
        }
        else if (sdkProvider == .APPLE)
        {
            
        }
    }
    func playTTS(with text: String) {
        //cancel()
        if sdkProvider == .QQ {
            WXSpeechManager.shared.playTTS(with: text)
        }
        else if (sdkProvider == .APPLE)
        {
            SpeechUtteranceManager.shared.playTTS(with: text)
        }
    }
    func cancel()  {
        if sdkProvider == .QQ {
            WXSpeechManager.shared.cancel()
        }
        else if (sdkProvider == .APPLE)
        {
            SpeechUtteranceManager.shared.cancel()
        }
    }
    func releaseResource() {
        if sdkProvider == .QQ {
            WXSpeechManager.shared.releaseResource()
        }
        else if (sdkProvider == .APPLE)
        {
            SpeechUtteranceManager.shared.releaseResource()
        }
    }
}
