//
//  DictionaryManagerRouterProtocol.swift
//  Dictionary
//
//  Created by silchenko on 04.03.2020.
//  Copyright © 2020 silchenko. All rights reserved.
//

import Foundation

extension UI.DictionaryManage.Router {
    
    enum `Type` {
        case add
        case edit(word: Word)
    }
}

protocol DictionaryManageRouterProtocol: class {

    func show(type: UI.DictionaryManage.Router.`Type`,
            method: Navigation.Method,
          animated: Bool,
        completion: @escaping VoidBlock)

    func hide(animated: Bool, completion: VoidBlock?)
}
