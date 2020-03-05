//
//  BaseRouter.swift
//  Dictionary
//
//  Created by silchenko on 03.03.2020.
//  Copyright © 2020 silchenko. All rights reserved.
//

import UIKit

typealias VoidBlock = () -> ()

protocol BaseRoutingProtocol {
    var navigationMethod: Navigation.Method? { get }
}

class BaseRouter: BaseRoutingProtocol {

    var initialVCIndex: Int?

    fileprivate(set) var navigationMethod: Navigation.Method?

    fileprivate var navigationAnchorController: UIViewController?
    fileprivate var initialController: UIViewController?

    func show(initialController: UIViewController,
                         method: Navigation.Method,
                       animated: Bool,
                     completion: VoidBlock? = nil) {

        self.navigationMethod = method
        self.initialController = initialController

        switch method {
        case .modal(let source):
            source.present(initialController, animated: animated)
        case .embedded(let controller):
            self.navigationAnchorController = controller.viewControllers.last
            self.initialVCIndex = controller.viewControllers.count + 1

            if let initialNavigationStack = initialController as? UINavigationController {
                controller.push(controllers: initialNavigationStack.viewControllers,
                                   animated: animated)
            } else {
                controller.push(controller: initialController,
                                  animated: animated)
            }
        }
    }

    func hide(animated: Bool, completion: VoidBlock? = nil) {

        guard let requiredMethod = navigationMethod else { return }

        switch requiredMethod {
        case .modal(_):

            guard let requiredInitialController = initialController else {

                completion?()
                return
            }
            requiredInitialController.dismiss(animated: animated, completion: completion)

        case .embedded(let controller):

            if let requiredAnchorController = navigationAnchorController {
                controller.popToViewController(requiredAnchorController, animated: animated)
            }
            else {
                controller.viewControllers = []
            }

            completion?()
        }

        initialController = nil
        navigationAnchorController = nil
        navigationMethod = nil
        initialVCIndex = nil
    }
}

