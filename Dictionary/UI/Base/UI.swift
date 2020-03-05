//
//  UI.swift
//  Dictionary
//
//  Created by silchenko on 03.03.2020.
//  Copyright © 2020 silchenko. All rights reserved.
//

import UIKit

struct UI {
    
    struct s {}
}

struct Navigation {

    enum Method {

        case modal(source: UIViewController)
        case embedded(inside: UINavigationController)

        var navigationController: UINavigationController? {

            switch self {
            case .modal(_): return nil
            case .embedded(let controller): return controller
            }
        }
    }
}
