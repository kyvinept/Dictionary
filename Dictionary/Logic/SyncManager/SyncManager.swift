//
//  SyncManager.swift
//  Dictionary
//
//  Created by silchenko on 03.03.2020.
//  Copyright © 2020 silchenko. All rights reserved.
//

import UIKit

class SyncManager {
    
    enum CustomNotification: String {
        case didSynchronized
    }
    
    fileprivate let keyStore = NSUbiquitousKeyValueStore.default
    
    init() {
        keyStore.synchronize()
        setupNotification()
    }
}

extension SyncManager: SyncManagerProtocol {
    
    func save(word: Word) {
        
        keyStore.set(word.dictionary, forKey: "[Word]: \(word.foreign)")
        
        word.tags.forEach({ save(tag: $0) })
        
        keyStore.synchronize()
    }
    
    func save(tag: Tag) {
        
        keyStore.set(tag.dictionary, forKey: "[Tag]: \(tag.name)")
        keyStore.synchronize()
    }
    
    func getAllWords() -> [Word] {
        
        let dictionary = keyStore.dictionaryRepresentation
        
        var words = [Word]()
        dictionary.forEach { (key: String, value: Any) in
            
            if let wordDictionary = value as? [String : Any],
               let word = Word(dictionary: wordDictionary) {
             
                words.append(word)
            }
        }
        
        return words
    }
    
    func getAllTags() -> [Tag] {
        
        let dictionary = keyStore.dictionaryRepresentation
        
        var tags = [Tag]()
        dictionary.forEach { (key: String, value: Any) in
            
            if let tagDictionary = value as? [String : Any],
               let tag = Tag(dictionary: tagDictionary) {
             
                tags.append(tag)
            }
        }
        
        return tags
    }
    
    func remove(word: String) {
        
//        save(word: word, translatedWord: "")
    }
}

fileprivate extension SyncManager {
    
    func setupNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(SyncManager.iCloudWasUpdated),
                                                   name: NSUbiquitousKeyValueStore.didChangeExternallyNotification,
                                                 object: NSUbiquitousKeyValueStore.default)
    }
    
    @objc func iCloudWasUpdated() {
        NotificationCenter.default.post(name: Notification.Name(CustomNotification.didSynchronized.rawValue), object: nil)
    }
}
