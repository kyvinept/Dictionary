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
    
    var navigationBarHeight: CGFloat {
        
        guard let navigationBarHeight = navigationBar?.frame.height,
              let topViewHeight = topView?.frame.height else {
            return 0
        }
        
        return navigationBarHeight + topViewHeight
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBarStyle()
    }
    
    func hideNavigationBar() {
        
        navigationBar?.isHidden = true
        topView?.isHidden = true
    }
}

fileprivate extension BaseViewController {
    
    func configureNavigationBarStyle() {
        
        navigationBar?.backgroundColor = Design.Color.white
        topView?.backgroundColor = Design.Color.white
    }
}
