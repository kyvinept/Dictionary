//
//  AccessibilityLabel.swift
//  accessibility
//
//  Created by silchenko on 02.03.2020.
//  Copyright © 2020 silchenko. All rights reserved.
//

import UIKit

@IBDesignable class AccessibilityLabel: UILabel {

    @IBInspectable var minFontSize: CGFloat = 5 {
        didSet {
            fontToFitHeight()
        }
    }
    
    @IBInspectable var maxFontSize: CGFloat = 200 {
        didSet {
            fontToFitHeight()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        fontToFitHeight()
    }
    
    private func fontToFitHeight() {

        if maxFontSize < font.pointSize {
            font = font.withSize(maxFontSize)
        }
        
        if minFontSize > font.pointSize {
            font = font.withSize(minFontSize)
        }
    }
}
