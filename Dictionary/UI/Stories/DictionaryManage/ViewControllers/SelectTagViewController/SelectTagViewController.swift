//
//  SelectTagViewController.swift
//  Dictionary
//
//  Created by silchenko on 05.03.2020.
//  Copyright © 2020 silchenko. All rights reserved.
//

import UIKit

protocol SelectTagViewControllerDelegate: class {
    func selectTagViewControllerDidTappedBackButton(_ viewController: SelectTagViewController)
    func selectTagViewControllerDidTappedNewTagButton(_ viewController: SelectTagViewController)
    func selectTagViewController(_ viewController: SelectTagViewController, didSelectExistTag tag: Tag)
}

class SelectTagViewController: BaseViewController {
    
    weak var delegate: SelectTagViewControllerDelegate?
    
    var tags: [Tag] = []
    
    @IBOutlet weak var newTagButton: UIButton!
    @IBOutlet fileprivate weak var bottomViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var bottomViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var backgroundView: UIButton!
    @IBOutlet fileprivate weak var bottomView: UIView!
    @IBOutlet fileprivate weak var tagsView: UIView!
    @IBOutlet fileprivate weak var tagsViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var arrowView: UIView!
    
    fileprivate var startedClose = false
    fileprivate let appearAnimationDuration = 0.4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideNavigationBar()
        
        configureConstraints()
        configureTags()
        setupGestures()
        setupAccessibility()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        animationForLayout()
    }
    
    @IBAction func backgroundViewTapped(_ sender: Any) {
        
        closeScreenAnimatedly(completion: { [weak self] _ in
            
            guard let strongSelf = self else { return }
            strongSelf.delegate?.selectTagViewControllerDidTappedBackButton(strongSelf)
        })
    }
    
    @IBAction func newTagButtonTapped(_ sender: Any) {
        
        closeScreenAnimatedly(completion: { [weak self] _ in
            
            guard let strongSelf = self else { return }
            strongSelf.delegate?.selectTagViewControllerDidTappedNewTagButton(strongSelf)
        })
    }
    
    func closeScreenAnimatedly(completion: @escaping ((Bool) -> Void)) {
        
        startedClose = true
        
        UIView.animate(withDuration: appearAnimationDuration,
                         animations: {
                                         self.backgroundView.backgroundColor = UIColor.clear
                                         self.bottomViewBottomConstraint.constant = -self.bottomView.frame.height
                                        
                                         self.view.layoutIfNeeded()
                                     },
                         completion: completion)
    }
}

// MARK: - CONFIGURATIONS
fileprivate extension SelectTagViewController {
    
    func setupAccessibility() {
        
        backgroundView.accessibilityLabel = "Background view"
        backgroundView.accessibilityHint = "Tap to close select tag screen"
        
        newTagButton.accessibilityLabel = "New tag button"
        newTagButton.accessibilityHint = "Tap to input new tag"
    }
    
    func configureConstraints() {
        
        bottomViewBottomConstraint.constant = -bottomView.frame.height
        bottomViewHeightConstraint.constant = view.frame.height / 2
        
        view.layoutIfNeeded()
    }
    
    func setupGestures() {
        
        let pinGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGestureInArrowView(_:)))
        arrowView.addGestureRecognizer(pinGesture)
    }
    
    func configureTags() {
        
        let completion: (_ tag: Tag) -> () = { [weak self] tag in
            
            guard let strongSelf = self else { return }
            
            strongSelf.closeScreenAnimatedly { _ in
                
                strongSelf.delegate?.selectTagViewController(strongSelf,
                                                             didSelectExistTag: tag)
            }
        }
        
        let viewHeight = tagsView.configureTagsView(withTags: tags,
                                                   textStyle: .body,
                                                  completion: completion)
        
        tagsViewHeightConstraint.constant = viewHeight
    }
    
    func animationForLayout() {
        
        UIView.animate(withDuration: appearAnimationDuration) {
            
            self.backgroundView.backgroundColor = Design.Color.transparentBlackColor
            self.bottomViewBottomConstraint.constant = 0
            
            self.view.layoutIfNeeded()
        }
    }
}

// MARK: - GESTURE RECOGNIZER
fileprivate extension SelectTagViewController {

    @objc func handlePanGestureInArrowView(_ gesture: UIPanGestureRecognizer) {
        
        guard !startedClose else {
            return
        }
        
        let translation = gesture.translation(in: self.view)
        
        if bottomViewHeightConstraint.constant - translation.y < view.frame.height / 4 {

            closeScreenAnimatedly(completion: { [weak self] _ in
                
                guard let strongSelf = self else { return }
                strongSelf.delegate?.selectTagViewControllerDidTappedBackButton(strongSelf)
            })
            
            return
        }
        
        if bottomViewHeightConstraint.constant - translation.y > view.frame.height - navigationBarHeight {
            bottomViewHeightConstraint.constant = view.frame.height - navigationBarHeight
            
            return
        }
        
        if bottomViewHeightConstraint.constant - translation.y < view.frame.height - navigationBarHeight {
            bottomViewHeightConstraint.constant -= translation.y
        }
        
        gesture.setTranslation(CGPoint.zero, in: self.view)
    }
}
