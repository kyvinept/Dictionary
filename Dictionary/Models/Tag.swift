//
//  Tags.swift
//  Dictionary
//
//  Created by silchenko on 05.03.2020.
//  Copyright © 2020 silchenko. All rights reserved.
//

import Foundation

struct Tag {
    
    var name: String
    
    var dictionary: [String: Any] {
        return [
            "name": name
        ]
    }
    
    init(name: String) {
        self.name = name
    }
    
    init?(dictionary: [String: Any]) {
        guard let name = dictionary["name"] as? String else {
            return nil
        }
        
        self.name = name
    }
}
