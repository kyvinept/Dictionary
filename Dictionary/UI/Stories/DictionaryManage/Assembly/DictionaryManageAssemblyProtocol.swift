//
//  DictionaryManageAssemblyProtocol.swift
//  Dictionary
//
//  Created by silchenko on 04.03.2020.
//  Copyright © 2020 silchenko. All rights reserved.
//

import UIKit

protocol DictionaryManageAssemblyProtocol {
    
    var syncManager: SyncManagerProtocol { get }
    
    func assemblyAddWordViewController(word: Word?,
                                 isEditMode: Bool,
                                   delegate: AddWordViewControllerDelegate) -> AddWordViewController
    func assemblySelectTagViewController(tags: [Tag],
                                     delegate: SelectTagViewControllerDelegate) -> SelectTagViewController
}
