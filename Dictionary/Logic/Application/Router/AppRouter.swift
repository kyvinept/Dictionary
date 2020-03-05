//
//  AppRouter.swift
//  Dictionary
//
//  Created by silchenko on 03.03.2020.
//  Copyright © 2020 silchenko. All rights reserved.
//

import UIKit

extension App {
    
    class Router {
        
        let appAssembly: AppAssemblyProtocol
        
        fileprivate var appWindow: UIWindow?
        fileprivate var navigationController: UINavigationController!
        
        fileprivate var dictionaryListRouter: DictionaryListRouterProtocol?
        
        required init(appAssembly: AppAssemblyProtocol) {

            self.appAssembly = appAssembly
        }
    }
}

extension App.Router: AppRouterProtocol {
    
    func show(from window: UIWindow) {
        
        self.appWindow = window
        self.showInitialUI(from: window)
    }
}

fileprivate extension App.Router {
    
    func showInitialUI(from window: UIWindow) {
        
        let navVC = UINavigationController()
        navVC.isNavigationBarHidden = true
        window.rootViewController = navVC
        navigationController = navVC

        self.showInitialUI(in: navVC)
    }
    
    func showInitialUI(in navigationController: UINavigationController) {

        showDictionaryListStory(in: navigationController,
                          animated: true,
                   storyCompletion: {})
    }
    
    func showDictionaryListStory(in viewController: UINavigationController,
                                          animated: Bool,
                                   storyCompletion: VoidBlock?) {

        let dictionaryListRouter = appAssembly.assemblyDictionaryListRouter()
        self.dictionaryListRouter = dictionaryListRouter
        
        dictionaryListRouter.show(method: .embedded(inside: viewController),
                                animated: animated,
                              completion: {})
    }
}
