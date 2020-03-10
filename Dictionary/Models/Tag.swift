//
//  Tags.swift
//  Dictionary
//
//  Created by silchenko on 05.03.2020.
//  Copyright © 2020 silchenko. All rights reserved.
//

import Foundation

struct Tag {
    
    var id: String
    var name: String
    
    var dictionary: [String: Any] {
        return [
            "id": id,
            "name": name
        ]
    }
    
    init(id: String,
       name: String) {
        
        self.id = id
        self.name = name
    }
    
    init?(dictionary: [String: Any]) {
        guard let id = dictionary["id"] as? String,
              let name = dictionary["name"] as? String else {
            return nil
        }
        
        self.id = id
        self.name = name
    }
}
