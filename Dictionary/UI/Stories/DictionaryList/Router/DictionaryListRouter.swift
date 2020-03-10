//
//  DictionaryListRouter.swift
//  Dictionary
//
//  Created by silchenko on 03.03.2020.
//  Copyright © 2020 silchenko. All rights reserved.
//

import UIKit

extension UI.DictionaryList {

    class Router: BaseRouter {

        fileprivate let assembly: DictionaryListAssemblyProtocol
        
        fileprivate let dictionaryManageRouter: DictionaryManageRouterProtocol

        fileprivate weak var parentNavigationController: UINavigationController?
        fileprivate weak var dictionaryListViewController: DictionaryListViewController?

        fileprivate var completion: VoidBlock?

        init(assembly: DictionaryListAssemblyProtocol,
dictionaryManageRouter: DictionaryManageRouterProtocol) {

            self.assembly = assembly
            self.dictionaryManageRouter = dictionaryManageRouter
            
            super.init()
            
            setupNotifications()
        }
    }
}

extension UI.DictionaryList.Router: DictionaryListRouterProtocol {

    func show(method: Navigation.Method,
            animated: Bool,
          completion: @escaping VoidBlock) {

        self.completion = completion
        
        showDictionaryListViewController(with: method, animated: animated)
    }
}

fileprivate extension UI.DictionaryList.Router {
    
    func setupNotifications() {
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(UI.DictionaryList.Router.cloudWasUpdated),
                                                   name: Notification.Name(SyncManager.CustomNotification.didSynchronized.rawValue),
                                                 object: nil)

    }

    func showDictionaryListViewController(with method: Navigation.Method, animated: Bool) {
        
        let dictionaryListViewController = assembly.assemblyDictionaryListViewController(delegate: self)
        self.dictionaryListViewController = dictionaryListViewController

        self.show(initialController: dictionaryListViewController,
                             method: method,
                           animated: animated)
    }
    
    @objc func cloudWasUpdated() {
        
        let wordsDictionary = assembly.syncManager.getAllWords()
        dictionaryListViewController?.update(wordsDictionary: wordsDictionary)
    }
}

extension UI.DictionaryList.Router: DictionaryListViewControllerDelegate {
    
    func dictionaryListViewController(_ viewController: DictionaryListViewController, didTappedSpeechButton text: String) {
        
        assembly.speechManager.speech(text: text)
    }
    
    func dictionaryListViewController(_ viewController: DictionaryListViewController, didSelectWord word: Word) {
        
        guard let navigationController = viewController.navigationController else {
            return
        }
        
        dictionaryManageRouter.show(type: .edit(word: word),
                                  method: .embedded(inside: navigationController),
                                animated: true,
                              completion: {
                                
            let wordsDictionary = self.assembly.syncManager.getAllWords()
            self.dictionaryListViewController?.update(wordsDictionary: wordsDictionary)
        })
    }
 
    func dictionaryListViewControllerDidTappedPlusButton(_ viewController: DictionaryListViewController) {
        
        guard let navigationController = viewController.navigationController else {
            return
        }
        
        dictionaryManageRouter.show(type: .add,
                                  method: .embedded(inside: navigationController),
                                animated: true,
                              completion: {
                                
            let wordsDictionary = self.assembly.syncManager.getAllWords()
            self.dictionaryListViewController?.update(wordsDictionary: wordsDictionary)
        })
    }
}
