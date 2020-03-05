//
//  LargeContentView.swift
//  accessibility
//
//  Created by silchenko on 02.03.2020.
//  Copyright © 2020 silchenko. All rights reserved.
//

import UIKit

@IBDesignable class NavigationBar: UIView {
    
    var rightButtonAction: (() -> ())?
    var leftButtonAction: (() -> ())?
    
    override var backgroundColor: UIColor? {
        didSet {
            view?.backgroundColor = backgroundColor
        }
    }
    
    @IBOutlet fileprivate weak var rightButton: UIButton!
    @IBOutlet fileprivate weak var leftButton: UIButton!
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
            rightButton.setTitle(rightButtonText, for: .normal)
            rightButton.isHidden = false
        }
    }
    
    @IBInspectable var rightButtonContentInsert: CGFloat = 0 {
        didSet {
            rightButton.contentEdgeInsets = UIEdgeInsets(top: rightButtonContentInsert,
                                                        left: rightButtonContentInsert,
                                                      bottom: rightButtonContentInsert,
                                                       right: rightButtonContentInsert)
        }
    }
    
    @IBInspectable var rightButtonImage: UIImage? {
        didSet {
            rightButton.setImage(rightButtonImage, for: .normal)
            rightButton.isHidden = false
        }
    }
    
    @IBInspectable var leftButtonText: String? {
        didSet {
            leftButton.setTitle(leftButtonText, for: .normal)
            leftButton.isHidden = false
        }
    }
       
    @IBInspectable var leftButtonImage: UIImage? {
        didSet {
            leftButton.setImage(leftButtonImage, for: .normal)
            leftButton.isHidden = false
        }
    }
    
    @IBInspectable var leftButtonContentInsert: CGFloat = 0 {
        didSet {
            leftButton.contentEdgeInsets = UIEdgeInsets(top: leftButtonContentInsert,
                                                       left: leftButtonContentInsert,
                                                     bottom: leftButtonContentInsert,
                                                      right: leftButtonContentInsert)
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
    
    @IBAction func leftButtonTapped(_ sender: Any) {
        
        leftButtonAction?()
    }
}

fileprivate extension NavigationBar {
    
    func setupView() {
        
        view = nibSetup()
        setupAccessibility()
    }
    
    func setupAccessibility() {
        
        view.enableLargeContentViewer(title: title,
                                       image: UIImage(named: "house"),
                                    delegate: self)
        
        rightButton.enableLargeContentViewer(title: "Plus",
                                             image: Design.Image.plusButtonInCircle.uiImage,
                                          delegate: nil)
        
        label.accessibilityLabel = title
        label.accessibilityTraits = .header
        
        rightButton.accessibilityLabel = "Plus"
        rightButton.accessibilityTraits = .button
        rightButton.accessibilityHint = "Will be opened add word screen"
        rightButton.accessibilityRespondsToUserInteraction = true
        rightButton.accessibilityUserInputLabels = ["plus", "add word", "plus button", "add word button"]
    }
}

extension NavigationBar: UILargeContentViewerInteractionDelegate {
     
}
