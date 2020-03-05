//
//  SceneDelegate.swift
//  Dictionary
//
//  Created by silchenko on 03.03.2020.
//  Copyright © 2020 silchenko. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder {

    var router: AppRouterProtocol!
    var assembly: AppAssemblyProtocol!
    var window: UIWindow?
}

extension SceneDelegate: UIWindowSceneDelegate {
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let _ = (scene as? UIWindowScene),
              let windowScene = scene as? UIWindowScene else {
            return
        }
        
        let window = UIWindow(windowScene: windowScene)
        self.window = window

        assembly = App.Assembly(window: window)
        router = assembly.assemblyAppRouter()

        self.setupWindow()
    }
}

fileprivate extension SceneDelegate {
    func setupWindow() {
        
        guard let window = self.window else {
            return
        }

        router.show(from: window)
        window.makeKeyAndVisible()
    }
}
