//
//  DictionaryListAssembly.swift
//  Dictionary
//
//  Created by silchenko on 03.03.2020.
//  Copyright © 2020 silchenko. All rights reserved.
//

import UIKit

extension UI.DictionaryList {

    class Assembly {

        fileprivate let assembly: AppAssemblyProtocol
        
        lazy var syncManager = assembly.assemblySyncManager()

        required init(assembly: AppAssemblyProtocol) {

            self.assembly = assembly
        }
    }
}

extension UI.DictionaryList.Assembly: DictionaryListAssemblyProtocol {
    
    func assemblyDictionaryListViewController(delegate: DictionaryListViewControllerDelegate) -> DictionaryListViewController {
        
        let dictionaryListVC = DictionaryListViewController.from(storyboard: storyboard)
        dictionaryListVC.delegate = delegate
        dictionaryListVC.wordsDictionary = syncManager.getAllWords()
                        
        return dictionaryListVC
    }
}

fileprivate extension UI.DictionaryList.Assembly {

    var storyboard: UIStoryboard { return UIStoryboard(name: "DictionaryList", bundle: nil) }
}
