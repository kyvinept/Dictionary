//
//  UINavigationController.swift
//  Dictionary
//
//  Created by silchenko on 03.03.2020.
//  Copyright © 2020 silchenko. All rights reserved.
//

import UIKit

extension UINavigationController {

    func push(controller: UIViewController, animated: Bool) {
        self.pushViewController(controller, animated: animated)
    }

    func push(controllers: [UIViewController], animated: Bool) {

        guard !controllers.isEmpty else { return }

        var viewControllers = self.viewControllers
        viewControllers.append(contentsOf: controllers)
        self.setViewControllers(viewControllers, animated: animated)
    }

    func pop(_ viewController: UIViewController,
                     animated: Bool = true) {

        let updates = self.controllers(byRemoving: viewController)
        let newControllers = updates.controllers

        guard (updates.index != nil),
              !newControllers.isEmpty
        else { return }

        self.setViewControllers(newControllers, animated: animated)
    }
}

fileprivate extension UINavigationController {

    func controllers(byRemoving viewController: UIViewController) -> (controllers: [UIViewController], index: Int?) {

        let reversedControllers = Array(viewControllers.reversed())

        guard let reversedIndex = reversedControllers.index(of: viewController)
        else {
            return (controllers: viewControllers, index: nil)
        }

        let index = (viewControllers.count - 1) - reversedIndex

        var newControllers = viewControllers
        newControllers.remove(at: index)

        return (controllers: newControllers, index: index)
    }
}

