//
//  UIViewController.swift
//  Dictionary
//
//  Created by silchenko on 03.03.2020.
//  Copyright © 2020 silchenko. All rights reserved.
//

import UIKit

extension UIViewController {

    public class func from(storyboardNamed name: String,
                                     identifier: String? = nil,
                                         bundle: Bundle) -> Self {

        let storyboard = UIStoryboard(name: name, bundle: bundle)

        return self.from(storyboard: storyboard, identifier: identifier)
    }

    public class func from(storyboard: UIStoryboard,
                           identifier: String? = nil) -> Self {

        let targetIdentifier = identifier ?? String(describing: self)

        return storyboard.viewController(named: targetIdentifier)
    }
}

