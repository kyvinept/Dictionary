//
//  AppRouterProtocol.swift
//  Dictionary
//
//  Created by silchenko on 03.03.2020.
//  Copyright © 2020 silchenko. All rights reserved.
//

import UIKit

protocol AppRouterProtocol {
    
    var appAssembly: AppAssemblyProtocol { get }
    
    func show(from window: UIWindow)
}
