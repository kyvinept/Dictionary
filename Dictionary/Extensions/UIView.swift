//
//  UIView.swift
//  Dictionary
//
//  Created by silchenko on 03.03.2020.
//  Copyright © 2020 silchenko. All rights reserved.
//

import UIKit

extension UIView {
    
    func nibSetup() -> UIView {
        
        let view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true

        addSubview(view)
        
        return view
    }

    func loadViewFromNib() -> UIView {
        
        let nib = UINib(nibName: String(describing: self.classForCoder), bundle: nil)
        let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView

        return nibView
    }
    
    func enableLargeContentViewer(title: String?,
                                  image: UIImage?,
                                  delegate: UILargeContentViewerInteractionDelegate?) {
        
        showsLargeContentViewer = true
        addInteraction(UILargeContentViewerInteraction(delegate: delegate))
        largeContentTitle = title
        largeContentImage = image
    }
    
    func configureTagsView(withTags tags: [Tag], textStyle: UIFont.TextStyle) -> CGFloat {
        
        var x: CGFloat = 0
        var y: CGFloat = 0
        var prevOffsetHeight: CGFloat = 0
        
        tags.forEach { tag in
            
            let label = UILabel()
            label.text = tag.name
            label.font = UIFont.preferredFont(forTextStyle: textStyle)
            label.sizeToFit()
            
            let tagView = TagView(labelFrame: label.frame)
            tagView.configure(with: TagViewViewModel(name: tag.name, textStyle: textStyle))
            
            if self.frame.width - x < tagView.frame.width {
                x = 0
                y += prevOffsetHeight
                prevOffsetHeight = 0
            }
            
            tagView.frame.origin.x = x
            tagView.frame.origin.y = y
            self.addSubview(tagView)
            
            x += tagView.frame.width
            
            if self.frame.width < tagView.frame.width {
                tagView.frame.size.width = self.frame.width
            }
            
            if prevOffsetHeight < tagView.frame.height {
                prevOffsetHeight = tagView.frame.height
            }
        }
        
        return y + prevOffsetHeight
    }
}
