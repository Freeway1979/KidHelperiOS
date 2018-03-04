//
//  SpeechUtteranceManager.swift
//  KidHelper
//
//  Created by Liu PingAn on 28/02/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

import Foundation
import AVFoundation

class SpeechUtteranceManager:NSObject {
    /// 单例管理语音播报 比较适用于多种类型语音播报管理
    public static let shared = SpeechUtteranceManager()
    var synthesizer = AVSpeechSynthesizer()
    var speechUtterance: AVSpeechUtterance?
    var voiceType = AVSpeechSynthesisVoice(language: Locale.current.languageCode)
    
    private override init() {
        super.init()
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, with: .duckOthers)
        } catch {
            print(error.localizedDescription)
        }
        synthesizer.delegate = self
    }
    

    func playTTS(with text: String) {
        if let _ = speechUtterance {
            synthesizer.stopSpeaking(at: .immediate)
        }
        
        do {
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print(error.localizedDescription)
        }
        
        speechUtterance = AVSpeechUtterance(string: text)
        
        speechUtterance?.voice = voiceType
        speechUtterance?.rate = 0.5
        synthesizer.speak(speechUtterance!)
    }
    
    func cancel()  {
       synthesizer.stopSpeaking(at: .immediate)
        do {
            try AVAudioSession.sharedInstance().setActive(false, with: .notifyOthersOnDeactivation)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func releaseResource() {
        cancel()
    }
}

extension SpeechUtteranceManager: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        do {
            try AVAudioSession.sharedInstance().setActive(false, with: .notifyOthersOnDeactivation)
        } catch {
            print(error.localizedDescription)
        }
        speechUtterance = nil
    }
}

