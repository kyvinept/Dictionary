//
//  DictionaryListViewController.swift
//  Dictionary
//
//  Created by silchenko on 03.03.2020.
//  Copyright © 2020 silchenko. All rights reserved.
//

import UIKit

protocol DictionaryListViewControllerDelegate: class {
    func dictionaryListViewControllerDidTappedPlusButton(_ viewController: DictionaryListViewController)
}

class DictionaryListViewController: BaseViewController {
    
    weak var delegate: DictionaryListViewControllerDelegate?
    var wordsDictionary: [Word] = []
    
    fileprivate let cellIdentifier = "WordCell"
    @IBOutlet fileprivate weak var wordsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        configureNavigationBar()
    }
    
    func update(wordsDictionary: [Word]) {
        
        self.wordsDictionary = wordsDictionary
        
        wordsTableView.reloadData()
    }
}

fileprivate extension DictionaryListViewController {
    
    func configureTableView() {
        
        wordsTableView.delegate = self
        wordsTableView.dataSource = self
        
        wordsTableView.register(UINib(nibName: "WordCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    func configureNavigationBar() {
        
        navigationBar?.rightButtonAction = { [weak self] in
            
            guard let strongSelf = self else { return }
            strongSelf.delegate?.dictionaryListViewControllerDidTappedPlusButton(strongSelf)
        }
    }
}

extension DictionaryListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return wordsDictionary.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? WordCell
        if cell == nil {
            cell = WordCell(style: .default, reuseIdentifier: cellIdentifier)
        }
        
        cell?.configure(with: WordCellViewModel(foreignWord: wordsDictionary[indexPath.row].foreign,
                                             translatedWord: wordsDictionary[indexPath.row].translated,
                                                       tags: wordsDictionary[indexPath.row].tags))
        
        return cell!
    }
}

extension DictionaryListViewController: UITableViewDelegate {

}
