//
//  TextInput.swift
//  Dictionary
//
//  Created by silchenko on 04.03.2020.
//  Copyright © 2020 silchenko. All rights reserved.
//

import UIKit

class TextInputView: UIView {
    
    var updatedTextAction: ((_ text: String) -> ())?
    var didEndEditing: ((_ text: String) -> ())?
    
    @IBOutlet fileprivate weak var label: UILabel!
    @IBOutlet fileprivate weak var textField: UITextField!
        
    fileprivate var view: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    func configure(with model: TextInputViewViewModel) {
                
        label.text = model.topLabelText
        textField.text = model.textFieldText
        textField.placeholder = ""
    }
    
    func configureAccessibility(label: String) {
        
        textField.accessibilityLabel = label
    }
    
    func clear() {
        textField.text = ""
    }
    
    override func becomeFirstResponder() -> Bool {
        super.becomeFirstResponder()
        
        return textField.becomeFirstResponder()
    }
}

fileprivate extension TextInputView {
    
    func setupView() {
        
        view = nibSetup()
        configureTextField()
    }
    
    func configureTextField() {
        
        textField.text = ""
        textField.delegate = self
    }
}

extension TextInputView: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let text = textField.text,
           let textRange = Range(range, in: text) {
           let updatedText = text.replacingCharacters(in: textRange,
                                                    with: string)

            updatedTextAction?(updatedText)
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        didEndEditing?(textField.text ?? "")
    }
}
