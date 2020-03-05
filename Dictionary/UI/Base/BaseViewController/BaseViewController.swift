//
//  BaseViewController.swift
//  Dictionary
//
//  Created by silchenko on 03.03.2020.
//  Copyright © 2020 silchenko. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    @IBOutlet weak var topView: UIView?
    @IBOutlet weak var navigationBar: NavigationBar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBarStyle()
    }
}

fileprivate extension BaseViewController {
    
    func configureNavigationBarStyle() {
        
        navigationBar?.backgroundColor = Design.Color.white
        topView?.backgroundColor = Design.Color.white
    }
}
