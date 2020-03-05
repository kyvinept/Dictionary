//
//  DictionaryManagerRouter.swift
//  Dictionary
//
//  Created by silchenko on 04.03.2020.
//  Copyright © 2020 silchenko. All rights reserved.
//

import UIKit

extension UI.DictionaryManage {

    class Router: BaseRouter {

        fileprivate let assembly: DictionaryManageAssemblyProtocol

        fileprivate weak var addWordViewController: AddWordViewController?

        fileprivate var completion: VoidBlock?

        init(assembly: DictionaryManageAssemblyProtocol) {

            self.assembly = assembly
        }
    }
}

extension UI.DictionaryManage.Router: DictionaryManageRouterProtocol {

    func show(type: `Type`,
            method: Navigation.Method,
          animated: Bool,
        completion: @escaping VoidBlock) {

        self.completion = completion
        
        switch type {
        case .add:
            showAddWordViewController(with: method, animated: animated)
        }
    }
}

fileprivate extension UI.DictionaryManage.Router {

    func showAddWordViewController(with method: Navigation.Method, animated: Bool) {
        
        let addWordViewController = assembly.assemblyAddWordViewController(delegate: self)
        self.addWordViewController = addWordViewController

        self.show(initialController: addWordViewController,
                             method: method,
                           animated: animated)
    }
}

extension UI.DictionaryManage.Router: AddWordViewControllerDelegate {
    
    func addWordViewControllerDidTappedSaveButton(_ viewController: AddWordViewController, with model: Word) {
        
        assembly.syncManager.save(word: model)
        
        viewController.navigationController?.pop(viewController)
        completion?()
    }
    
    func addWordViewControllerDidTappedBackButton(_ viewController: AddWordViewController) {
        
        viewController.navigationController?.pop(viewController)
        completion?()
    }
}

