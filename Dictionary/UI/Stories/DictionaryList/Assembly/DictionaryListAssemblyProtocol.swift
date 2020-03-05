//
//  DictionaryListAssemblyProtocol.swift
//  Dictionary
//
//  Created by silchenko on 03.03.2020.
//  Copyright © 2020 silchenko. All rights reserved.
//

import UIKit

protocol DictionaryListAssemblyProtocol {
    
    var syncManager: SyncManagerProtocol { get }
    
    func assemblyDictionaryListViewController(delegate: DictionaryListViewControllerDelegate) -> DictionaryListViewController
}
