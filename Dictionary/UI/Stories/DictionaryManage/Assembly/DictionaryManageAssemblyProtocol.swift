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
    
    func assemblyAddWordViewController(delegate: AddWordViewControllerDelegate) -> AddWordViewController
}
