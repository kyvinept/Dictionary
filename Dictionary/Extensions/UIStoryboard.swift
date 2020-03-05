//
//  UIStoryboard.swift
//  Dictionary
//
//  Created by silchenko on 03.03.2020.
//  Copyright © 2020 silchenko. All rights reserved.
//

import UIKit

extension UIStoryboard {

    func viewController<T>(named: String) -> T {
        return self.instantiateViewController(withIdentifier: named) as! T
    }
}
