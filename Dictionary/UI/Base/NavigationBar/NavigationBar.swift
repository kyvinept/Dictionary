//
//  LargeContentView.swift
//  accessibility
//
//  Created by silchenko on 02.03.2020.
//  Copyright © 2020 silchenko. All rights reserved.
//

import UIKit

@IBDesignable class LargeContentView: UIView {
    
    var rightButtonAction: (() -> ())?
    
    @IBOutlet fileprivate weak var settingsButton: UIButton!
    @IBOutlet fileprivate weak var label: AccessibilityLabel!
    
    fileprivate var view: UIView!
    
    @IBInspectable var title: String? {
        didSet {
            label.text = title
            
            setupAccessibility()
        }
    }
    
    @IBInspectable var rightButtonText: String? {
        didSet {
            settingsButton.setTitle(rightButtonText, for: .normal)
        }
    }
    
    @IBInspectable var rightButtonImage: UIImage? {
        didSet {
            settingsButton.setImage(rightButtonImage, for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    @IBAction func rightButtonTapped(_ sender: Any) {
        
        rightButtonAction?()
    }
}

fileprivate extension LargeContentView {
    
    func setupView() {
        
        view = nibSetup()
        setupAccessibility()
    }
    
    func setupAccessibility() {
        
        view.enableLargeContentViewer(title: title,
                                       image: UIImage(named: "house"),
                                    delegate: self)
        
        settingsButton.enableLargeContentViewer(title: "Settings",
                                                image: UIImage(named: "settings"),
                                             delegate: nil)
        
        label.accessibilityLabel = title
        label.accessibilityTraits = .header
        
        settingsButton.accessibilityLabel = "Settings"
        settingsButton.accessibilityTraits = .button
        settingsButton.accessibilityHint = "Will be opened settings screen"
        settingsButton.accessibilityRespondsToUserInteraction = true
        settingsButton.accessibilityUserInputLabels = ["settings", "settings button"]
    }
}

extension LargeContentView: UILargeContentViewerInteractionDelegate {
     
}
