//
//  SyncManagerProtocol.swift
//  Dictionary
//
//  Created by silchenko on 03.03.2020.
//  Copyright © 2020 silchenko. All rights reserved.
//

import UIKit

protocol SyncManagerProtocol: SyncManagerWordProtocol, SyncManagerTagProtocol {}

protocol SyncManagerWordProtocol {
    
    func save(word: Word)
    func remove(word: String)
    func getAllWords() -> [Word]
}

protocol SyncManagerTagProtocol {
    
    func save(tag: Tag)
    func getAllTags() -> [Tag]
}
