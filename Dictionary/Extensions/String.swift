//
//  String.swift
//  Dictionary
//
//  Created by silchenko on 06.03.2020.
//  Copyright © 2020 silchenko. All rights reserved.
//

import NaturalLanguage

extension String {
    
    var languageCode: String? {
        
        let recognizer = NLLanguageRecognizer()
        recognizer.processString(self)
        guard let languageCode = recognizer.dominantLanguage?.rawValue else { return nil }
        return languageCode
    }
}
