//
//  Design.swift
//  Dictionary
//
//  Created by silchenko on 03.03.2020.
//  Copyright © 2020 silchenko. All rights reserved.
//

import UIKit

struct Design {
    
    struct Color {
        
        static let navigationBarBackgroundColor = UIColor(named: "navigationBarBackgroundColor")!
        static let white = UIColor(named: "white")!
        static let transparentBlackColor = UIColor(named: "transparentBlackColor")!
    }
    
    enum Image {
        
        case plusButtonInCircle
        case backButtonArrow
    }
}

extension Design.Image {
    
    var accessibilityLabel: String {
        
        switch self {
        case .plusButtonInCircle:
            return "Plus"
        case .backButtonArrow:
            return ""
        }
    }
    
    var uiImage: UIImage {
        
        switch self {
        case .plusButtonInCircle:
            return UIImage(named: "plus_button_in_circle")!
        case .backButtonArrow:
            return UIImage(named: "back_button_arrow")!
        }
    }
}
