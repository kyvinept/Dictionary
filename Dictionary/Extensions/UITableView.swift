//
//  UITableViewController.swift
//  Dictionary
//
//  Created by silchenko on 04.03.2020.
//  Copyright © 2020 silchenko. All rights reserved.
//

import UIKit

extension UITableView {
    
    func cell<T: UITableViewCell>(withIdentifier identifier: String) -> T {
        
        var cell = self.dequeueReusableCell(withIdentifier: identifier) as? T
        if cell == nil {
            cell = T(style: .default, reuseIdentifier: identifier)
        }
        
        return cell!
    }
}
