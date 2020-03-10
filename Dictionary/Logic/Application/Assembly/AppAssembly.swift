//
//  AppAssembly.swift
//  Dictionary
//
//  Created by silchenko on 03.03.2020.
//  Copyright © 2020 silchenko. All rights reserved.
//

import UIKit

extension App {
    
    class Assembly {
        
        fileprivate let window: UIWindow
        
        fileprivate lazy var appRouter: App.Router = self.createAppRouter()
        
        fileprivate var syncManager: SyncManagerProtocol {
            return self.createSyncManager()
        }
        
        fileprivate var speechManager: SpeechManagerProtocol {
            return self.createSpeechManager()
        }

        required init(window: UIWindow) {

            self.window = window
        }
    }
}

extension App.Assembly: AppAssemblyProtocol {
    
    func assemblyAppRouter() -> AppRouterProtocol { return appRouter }
    func assemblyDictionaryListRouter() -> DictionaryListRouterProtocol { return self.createDictionaryListRouter() }
    func assemblyDictionaryManageRouter() -> DictionaryManageRouterProtocol { return self.createDictionaryManageRouter() }
    
    func assemblySyncManager() -> SyncManagerProtocol { return self.syncManager }
    func assemblySpeechManager() -> SpeechManagerProtocol { return self.speechManager }
}

fileprivate extension App.Assembly {

    func createAppRouter() -> App.Router {
        return App.Router(appAssembly: self)
    }
    
    func createDictionaryListRouter() -> DictionaryListRouterProtocol {
        
        let assembly = UI.DictionaryList.Assembly(assembly: self)
        return UI.DictionaryList.Router(assembly: assembly,
                          dictionaryManageRouter: self.createDictionaryManageRouter())
    }
    
    func createDictionaryManageRouter() -> DictionaryManageRouterProtocol {
        
        let assembly = UI.DictionaryManage.Assembly(assembly: self)
        return UI.DictionaryManage.Router(assembly: assembly)
    }
    
    func createSyncManager() -> SyncManager {
        
        return SyncManager()
    }
    
    func createSpeechManager() -> SpeechManager {
        
        return SpeechManager()
    }
}
