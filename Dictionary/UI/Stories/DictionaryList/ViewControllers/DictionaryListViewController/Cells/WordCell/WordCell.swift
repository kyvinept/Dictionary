//
//  WordCell.swift
//  Dictionary
//
//  Created by silchenko on 05.03.2020.
//  Copyright © 2020 silchenko. All rights reserved.
//

import UIKit

class WordCell: UITableViewCell {
    
    var speechTextAction: ((_ text: String) -> ())?

    @IBOutlet fileprivate weak var foreignLabel: UILabel!
    @IBOutlet fileprivate weak var translatedLabel: UILabel!
    @IBOutlet fileprivate weak var tagsViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var tagsView: UIView!
    @IBOutlet fileprivate weak var foreignSpeakerButton: UIButton!
    @IBOutlet fileprivate weak var translatedSpeakerButton: UIButton!
    
    fileprivate var tags: [Tag] = []
    fileprivate var model: WordCellViewModel?

    override func prepareForReuse() {
        super.prepareForReuse()
        
        tagsView.subviews.forEach { view in
            view.removeFromSuperview()
        }
    }
    
    func configure(with model: WordCellViewModel) {
        
        self.model = model
        
        foreignLabel.text = model.foreignWord
        translatedLabel.text = model.translatedWord
        tags = model.tags
        
        configureTagsView()
        configureAccessibility()
    }
    
    @IBAction func foreignSpeakerButtonTapped(_ sender: Any) {
        
        guard let text = model?.foreignWord else { return }
        speechTextAction?(text)
    }
    
    @IBAction func translatedSpeakerButtonTapped(_ sender: Any) {
        
        guard let text = model?.translatedWord else { return }
        speechTextAction?(text)
    }
}

fileprivate extension WordCell {
    
    func configureAccessibility() {
        
        foreignSpeakerButton.accessibilityLabel = "Foreign speaker button"
        foreignSpeakerButton.accessibilityHint = "Tap to speech foreign word"
        
        translatedSpeakerButton.accessibilityLabel = "Translated speaker button"
        translatedSpeakerButton.accessibilityHint = "Tap to speech translated word"
    }
    
    func configureTagsView() {
        
        let viewHeight = tagsView.configureTagsView(withTags: tags,
                                                   textStyle: .caption1,
                                                  completion: nil)
        tagsViewHeightConstraint.constant = viewHeight
    }
}
