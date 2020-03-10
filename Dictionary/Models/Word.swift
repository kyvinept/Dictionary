//
//  Word.swift
//  Dictionary
//
//  Created by silchenko on 03.03.2020.
//  Copyright © 2020 silchenko. All rights reserved.
//

import Foundation

struct Word {
    
    var id: String
    var foreign: String
    var translated: String
    var tags: [Tag]
    
    var dictionary: [String: Any] {
        return [
            "id":           id,
            "foreign":      foreign,
            "translated":   translated,
            "tags":         tags.map({ $0.dictionary })
        ]
    }
    
    init(id: String,
    foreign: String,
 translated: String,
       tags: [Tag]) {
        
        self.id = id
        self.foreign = foreign
        self.translated = translated
        self.tags = tags
    }
    
    init?(dictionary: [String: Any]) {
        
        guard let id = dictionary["id"] as? String,
              let foreign = dictionary["foreign"] as? String,
              let translated = dictionary["translated"] as? String,
              let tagsDictionary = dictionary["tags"] as? [[String: Any]] else {
                
            return nil
        }
        
        var tags = [Tag]()
        for i in 0 ..< tagsDictionary.count {
            
            guard let tag = Tag(dictionary: tagsDictionary[i]) else {
                return nil
            }
            
            tags.append(tag)
        }
        
        self.id = id
        self.foreign = foreign
        self.translated = translated
        self.tags = tags
    }
}
