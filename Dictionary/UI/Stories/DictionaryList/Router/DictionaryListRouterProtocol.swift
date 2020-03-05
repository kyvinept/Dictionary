//
//  DictionaryListRouterProtocol.swift
//  Dictionary
//
//  Created by silchenko on 03.03.2020.
//  Copyright © 2020 silchenko. All rights reserved.
//

import Foundation

protocol DictionaryListRouterProtocol: class {

    func show(method: Navigation.Method,
            animated: Bool,
          completion: @escaping VoidBlock)

    func hide(animated: Bool, completion: VoidBlock?)
}
