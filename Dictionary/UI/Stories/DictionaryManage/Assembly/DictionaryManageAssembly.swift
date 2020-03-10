//
//  DictionaryManageAssembly.swift
//  Dictionary
//
//  Created by silchenko on 04.03.2020.
//  Copyright © 2020 silchenko. All rights reserved.
//

import UIKit

extension UI.DictionaryManage {

    class Assembly {

        fileprivate let assembly: AppAssemblyProtocol
        
        lazy var syncManager = assembly.assemblySyncManager()

        required init(assembly: AppAssemblyProtocol) {

            self.assembly = assembly
        }
    }
}

extension UI.DictionaryManage.Assembly: DictionaryManageAssemblyProtocol {
    
    func assemblyAddWordViewController(word: Word?,
                                 isEditMode: Bool,
                                   delegate: AddWordViewControllerDelegate) -> AddWordViewController {

        let addWordVC = AddWordViewController.from(storyboard: storyboard)
        addWordVC.delegate = delegate
        addWordVC.word = word
        addWordVC.isEditMode = isEditMode
                        
        return addWordVC
    }
    
    func assemblySelectTagViewController(tags: [Tag],
                                     delegate: SelectTagViewControllerDelegate) -> SelectTagViewController {
        
        let selectTagVC = SelectTagViewController.from(storyboard: storyboard)
        selectTagVC.delegate = delegate
        selectTagVC.tags = tags
        
        return selectTagVC
    }
}

fileprivate extension UI.DictionaryManage.Assembly {

    var storyboard: UIStoryboard { return UIStoryboard(name: "DictionaryManage", bundle: nil) }
}
