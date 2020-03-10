
//
//  SpeechManager.swift
//  Dictionary
//
//  Created by silchenko on 06.03.2020.
//  Copyright © 2020 silchenko. All rights reserved.
//

import UIKit
import AVFoundation

class SpeechManager {
    
}

extension SpeechManager: SpeechManagerProtocol {
    
    func speech(text: String) {
        
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: text.languageCode)

        let synth = AVSpeechSynthesizer()
        synth.speak(utterance)
    }
}
