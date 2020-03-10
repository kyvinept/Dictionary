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
    func addWordViewControllerDidTappedTagsSelection(_ viewController: AddWordViewController)
}

class AddWordViewController: BaseViewController {

    weak var delegate: AddWordViewControllerDelegate?
    
    var word: Word? {
        didSet {
            guard let word = word else {
                return
            }
            
            foreignWord = word.foreign
            translatedWord = word.translated
            tags = word.tags
        }
    }
    
    var isEditMode: Bool = false
    
    @IBOutlet fileprivate weak var foreignWordInputView: TextInputView!
    @IBOutlet fileprivate weak var translatedWordInputView: TextInputView!
    @IBOutlet fileprivate weak var tagInputView: TextInputView!
    @IBOutlet fileprivate weak var tagsView: UIView!
    @IBOutlet fileprivate weak var tagsViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var tagInputButton: UIButton!
    
    fileprivate var foreignWord: String?
    fileprivate var translatedWord: String?
    fileprivate var tags: [Tag] = [] {
        didSet {
            configureTagsView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAccessibility()
        configureNavigationBar()
        configureViews()
        configureTagsView()
    }
    
    func tagInputStartInput() {
        
        let _ = tagInputView.becomeFirstResponder()
    }
    
    func addExistTagToWord(_ tag: Tag) {
        
        if tags.contains(where: { $0.id == tag.id }) {
            return
        }
        
        tags.append(tag)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
                
        guard let foreignWord = foreignWord,
              let translatedWord = translatedWord,
              !foreignWord.isEmpty,
              !translatedWord.isEmpty else {
            return
        }

        let word = Word(id: String(Date().timeIntervalSinceReferenceDate),
                   foreign: foreignWord,
                translated: translatedWord,
                      tags: tags)

        delegate?.addWordViewControllerDidTappedSaveButton(self, with: word)
    }
    
    @IBAction func selectTagButtonTapped(_ sender: Any) {
        
        delegate?.addWordViewControllerDidTappedTagsSelection(self)
    }
}

fileprivate extension AddWordViewController {
    
    func setupAccessibility() {
        
        foreignWordInputView.configureAccessibility(label: "Text field for input foreign word")
        translatedWordInputView.configureAccessibility(label: "Text field for input translated word")
        tagInputView.configureAccessibility(label: "Text field for input tag")
        
        tagInputButton.accessibilityLabel = "Tag input"
    }
    
    func configureTagsView() {
        
        guard tagsView != nil else {
            return
        }
        
        let tagsViewHeight = tagsView.configureTagsView(withTags: tags,
                                                       textStyle: .caption1,
                                                      completion: nil)
        tagsViewHeightConstraint.constant = tagsViewHeight
    }
    
    func configureNavigationBar() {
        
        if isEditMode {
            navigationBar?.title = Constant.AddWordScreen.editModeTitle
        } else {
            navigationBar?.title = Constant.AddWordScreen.addModeTitle
        }
        
        navigationBar?.leftButtonAction = { [weak self] in

            guard let strongSelf = self else { return }
            strongSelf.delegate?.addWordViewControllerDidTappedBackButton(strongSelf)
        }
    }
    
    func configureViews() {
        
        foreignWordInputView.configure(with: TextInputViewViewModel(topLabelText: "Foreign word",
                                                                   textFieldText: word?.foreign))
        foreignWordInputView.updatedTextAction = { [weak self] text in
            self?.foreignWord = text
        }
        
        translatedWordInputView.configure(with: TextInputViewViewModel(topLabelText: "Translated word",
                                                                      textFieldText: word?.translated))
        translatedWordInputView.updatedTextAction = { [weak self] text in
            self?.translatedWord = text
        }
        
        tagInputView.configure(with: TextInputViewViewModel(topLabelText: "Tag"))
        tagInputView.didEndEditing = { [weak self] text in
            
            guard !text.isEmpty else {
                return
            }
            
            self?.tags.append(Tag(id: String(Date().timeIntervalSinceReferenceDate),
                                name: text))
            self?.tagInputView.clear()
        }
    }
}
