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
    
    @IBInspectable var rightButtonAccessibilityLabel: String? {
        didSet {
            rightButton.accessibilityLabel = rightButtonAccessibilityLabel
        }
    }
    
    @IBInspectable var rightButtonAccessibilityHint: String? {
        didSet {
            rightButton.accessibilityHint = rightButtonAccessibilityHint
        }
    }
    
    @IBInspectable var rightButtonAccessibilityRespondsToUserInteraction: Bool = true {
        didSet {
            rightButton.accessibilityRespondsToUserInteraction = rightButtonAccessibilityRespondsToUserInteraction
        }
    }
    
//    @IBInspectable var rightButtonAccessibilityUserInputLabels: [String] = [] {
//        didSet {
//            rightButton.accessibilityUserInputLabels = rightButtonAccessibilityUserInputLabels
//        }
//    }
    
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
    
    @IBInspectable var leftButtonAccessibilityLabel: String? {
        didSet {
            leftButton.accessibilityLabel = leftButtonAccessibilityLabel
        }
    }
    
    @IBInspectable var leftButtonAccessibilityHint: String? {
        didSet {
            leftButton.accessibilityHint = leftButtonAccessibilityHint
        }
    }
    
    @IBInspectable var leftButtonAccessibilityRespondsToUserInteraction: Bool = true {
        didSet {
            leftButton.accessibilityRespondsToUserInteraction = leftButtonAccessibilityRespondsToUserInteraction
        }
    }
    
//    @IBInspectable var leftButtonAccessibilityUserInputLabels: [String] = [] {
//        didSet {
//            leftButton.accessibilityUserInputLabels = leftButtonAccessibilityUserInputLabels
//        }
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupAccessibility()
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
        
        leftButton.enableLargeContentViewer(title: leftButtonAccessibilityLabel,
                                            image: leftButtonImage,
                                         delegate: nil)
        
        rightButton.enableLargeContentViewer(title: rightButtonAccessibilityLabel,
                                             image: rightButtonImage,
                                          delegate: nil)
        
        label.accessibilityLabel = title
        label.accessibilityTraits = .header
        
        leftButton.accessibilityTraits = .button
        rightButton.accessibilityTraits = .button
    }
}

extension NavigationBar: UILargeContentViewerInteractionDelegate {
     
}
