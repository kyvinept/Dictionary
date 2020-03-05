//
//  AddWordViewController.swift
//  Dictionary
//
//  Created by silchenko on 04.03.2020.
//  Copyright © 2020 silchenko. All rights reserved.
//

import UIKit

protocol AddWordViewControllerDelegate: class {
    func addWordViewControllerDidTappedBackButton(_ viewController: AddWordViewController)
    func addWordViewControllerDidTappedSaveButton(_ viewController: AddWordViewController, with model: Word)
}

class AddWordViewController: BaseViewController {

    weak var delegate: AddWordViewControllerDelegate?
    
    @IBOutlet fileprivate weak var foreignWordInputView: TextInputView!
    @IBOutlet fileprivate weak var translatedWordInputView: TextInputView!
    @IBOutlet fileprivate weak var tagInputView: TextInputView!
    @IBOutlet fileprivate weak var tagsView: UIView!
    @IBOutlet fileprivate weak var tagsViewHeightConstraint: NSLayoutConstraint!
    
    fileprivate var foreignWord: String?
    fileprivate var translatedWord: String?
    fileprivate var tags: [Tag] = [] {
        didSet {
            let tagsViewHeight = tagsView.configureTagsView(withTags: tags, textStyle: .caption1)
            tagsViewHeightConstraint.constant = tagsViewHeight
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureViews()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        guard let foreignWord = foreignWord,
              let translatedWord = translatedWord,
              !foreignWord.isEmpty,
              !translatedWord.isEmpty else {
            return
        }
        
        let word = Word(foreign: foreignWord, translated: translatedWord, tags: tags)
        
        delegate?.addWordViewControllerDidTappedSaveButton(self, with: word)
    }
}

fileprivate extension AddWordViewController {
    
    func configureNavigationBar() {
        
        navigationBar?.leftButtonAction = { [weak self] in

            guard let strongSelf = self else { return }
            strongSelf.delegate?.addWordViewControllerDidTappedBackButton(strongSelf)
        }
    }
    
    func configureViews() {
        
        foreignWordInputView.configure(with: TextInputViewViewModel(placeholder: "Foreign word"))
        foreignWordInputView.updatedTextAction = { [weak self] text in
            self?.foreignWord = text
        }
        
        translatedWordInputView.configure(with: TextInputViewViewModel(placeholder: "Translated word"))
        translatedWordInputView.updatedTextAction = { [weak self] text in
            self?.translatedWord = text
        }
        
        tagInputView.configure(with: TextInputViewViewModel(placeholder: "Tag"))
        tagInputView.didEndEditing = { [weak self] text in
            self?.tags.append(Tag(name: text))
            self?.tagInputView.clear()
        }
    }
}
