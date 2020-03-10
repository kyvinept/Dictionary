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
        fileprivate weak var selectTagViewController: SelectTagViewController?

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
            
        case .edit(let word):
            showAddWordViewController(with: method, animated: animated, word: word)
        }
    }
}

fileprivate extension UI.DictionaryManage.Router {

    func showAddWordViewController(with method: Navigation.Method, animated: Bool, word: Word? = nil) {
        
        let addWordViewController = assembly.assemblyAddWordViewController(word: word,
                                                                     isEditMode: word != nil,
                                                                       delegate: self)
        self.addWordViewController = addWordViewController

        self.show(initialController: addWordViewController,
                             method: method,
                           animated: animated)
    }
    
    func showSelectTagViewController(from viewController: UIViewController, animated: Bool) {
        
        let tags = assembly.syncManager.getAllTags()
        
        let selectTagViewController = assembly.assemblySelectTagViewController(tags: tags, delegate: self)
        self.selectTagViewController = selectTagViewController
        
        selectTagViewController.modalPresentationStyle = .overCurrentContext

        self.show(initialController: selectTagViewController,
                             method: .modal(source: viewController),
                           animated: animated)
    }
}

extension UI.DictionaryManage.Router: SelectTagViewControllerDelegate {
    
    func selectTagViewController(_ viewController: SelectTagViewController, didSelectExistTag tag: Tag) {
        
        viewController.dismiss(animated: false, completion: nil)

        addWordViewController?.addExistTagToWord(tag)
    }
    
    func selectTagViewControllerDidTappedNewTagButton(_ viewController: SelectTagViewController) {
        
        viewController.dismiss(animated: false, completion: nil)
        
        addWordViewController?.tagInputStartInput()
    }
    
    func selectTagViewControllerDidTappedBackButton(_ viewController: SelectTagViewController) {
        viewController.dismiss(animated: false, completion: nil)
    }
}

extension UI.DictionaryManage.Router: AddWordViewControllerDelegate {
    
    func addWordViewControllerDidTappedTagsSelection(_ viewController: AddWordViewController) {
        
        showSelectTagViewController(from: viewController, animated: false)
    }
    
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

