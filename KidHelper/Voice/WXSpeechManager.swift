//
//  WXSpeechManager.swift
//  KidHelper
//
//  Created by Liu PingAn on 04/03/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

import UIKit


class WXSpeechManager: NSObject {
    public static let shared = WXSpeechManager()
    private static let DEMO_USER_KEY = "248b63f1ceca9158ca88516bcb338e82a482ecd802cbca12"
    lazy public var player:WXSpeechSynthesizerPlayer = WXSpeechSynthesizerPlayer()
    func releaseResource() {
        player.stop()
        WXSpeechSynthesizer.release()
    }
    
    func initSpeechEngine(delegate:WXSpeechSynthesizerDelegate,playerDelegate:WXSpeechSynthesizerPlayerDelegate,userKey:String = WXSpeechManager.DEMO_USER_KEY,volumn:Float = 1.0) {
        
        player.delegate = playerDelegate
        
        let synthersizer:WXSpeechSynthesizer = WXSpeechSynthesizer.shared()
        synthersizer.delegate = delegate
        synthersizer.setUserKey(userKey)
        synthersizer.setVolumn(volumn)
        
    }
    
    func playTTS(with text: String) {
        WXSpeechSynthesizer.shared().start(withText: text)
    }
    
    func cancel()  {
        WXSpeechSynthesizer.shared().cancel()
    }
}
