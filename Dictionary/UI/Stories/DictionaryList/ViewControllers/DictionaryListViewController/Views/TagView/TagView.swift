//
//  TagView.swift
//  Dictionary
//
//  Created by silchenko on 05.03.2020.
//  Copyright © 2020 silchenko. All rights reserved.
//

import UIKit

class TagView: UIView {
    
    var viewTapped: (() -> ())?
    
    @IBOutlet fileprivate weak var label: UILabel!
    @IBOutlet fileprivate weak var contentView: UIView!
    fileprivate var view: UIView!
    fileprivate var labelFrame: CGRect!
    
    fileprivate let widthOffsetToLabel: CGFloat = 24
    fileprivate let heightOffsetToLabel: CGFloat = 20
    
    init(labelFrame frame: CGRect) {
        
        let newFrame = CGRect(origin: frame.origin,
                                size: CGSize(width: frame.width + widthOffsetToLabel,
                                            height: frame.height + heightOffsetToLabel))
        
        self.labelFrame = frame
        super.init(frame: newFrame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        viewTapped?()
    }
    
    func configure(with model: TagViewViewModel) {
                
        label.text = model.name
        label.font = UIFont.preferredFont(forTextStyle: model.textStyle)
        contentView.layer.cornerRadius = labelFrame.height / 10 + 5
        
        setupAccessibility(with: model)
    }
}

fileprivate extension TagView {
    
    func setupView() {
        
        view = nibSetup()
    }
    
    func setupAccessibility(with model: TagViewViewModel) {
        
        contentView.accessibilityLabel = "tag: \(model.name)"
    }
}
