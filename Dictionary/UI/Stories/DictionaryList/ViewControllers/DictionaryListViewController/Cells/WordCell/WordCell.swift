//
//  WordCell.swift
//  Dictionary
//
//  Created by silchenko on 05.03.2020.
//  Copyright © 2020 silchenko. All rights reserved.
//

import UIKit

class WordCell: UITableViewCell {

    @IBOutlet fileprivate weak var foreignLabel: UILabel!
    @IBOutlet fileprivate weak var translatedLabel: UILabel!
    @IBOutlet fileprivate weak var tagsViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var tagsView: UIView!
    
    fileprivate var tags: [Tag] = []

    override func prepareForReuse() {
        super.prepareForReuse()
        
        tagsView.subviews.forEach { view in
            view.removeFromSuperview()
        }
    }
    
    func configure(with model: WordCellViewModel) {
        
        foreignLabel.text = model.foreignWord
        translatedLabel.text = model.translatedWord
        tags = model.tags
        
        configureTagsView()
    }
}

fileprivate extension WordCell {
    
    func configureTagsView() {
        
        let viewHeight = tagsView.configureTagsView(withTags: tags, textStyle: .caption1)
        tagsViewHeightConstraint.constant = viewHeight
    }
}
