//
//  SearchScreenViewController.swift
//  Bookshelf
//
//  Created by Anastasia on 06.02.2023.
//

import UIKit
import RxSwift

class SearchScreenViewController: UIViewController, StoryboardLoadable {
    
    //MARK: -
    //MARK: Properties
    
    @IBOutlet weak var searchBar: UISearchBar?
    @IBOutlet weak var tableView: UITableView?
    public var viewModel: SearchScreenViewModel!
    private var disposeBag: DisposeBag = .init()
    
    //MARK: -
    //MARK: Init and Deinit
    
    public static func startVC(viewModel: SearchScreenViewModel) -> SearchScreenViewController {
        let contr = self.loadFromStoryboard(storyboardName: "SearchScreen")
        contr.viewModel = viewModel
        return contr
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.register(SearchScreenTableViewCell.self, forCellReuseIdentifier: SearchScreenTableViewCell.cellId)
        addBinding()
    }
    
    deinit {
        print("Deinit: \(Self.self)")
    }
 
    //MARK: -
    //MARK: Private Methods
    
    private func addBinding() {
        searchBar?.searchTextField.rx.text
            .orEmpty
            .bind(onNext: { smthn in
                self.viewModel.searchTextObservable.accept(smthn.lowercased().replacingOccurrences(of: " ", with: "+"))
            }).disposed(by: disposeBag)
        searchBar?.rx.searchButtonClicked.bind(onNext: {_ in
            self.viewModel.setData()
            self.searchBar?.endEditing(true)
        }).disposed(by: disposeBag)
        self.viewModel.book.asObservable().bind(with: self, onNext: { this, _ in
            self.searchBar?.resignFirstResponder()
            this.tableView?.reloadData()}).disposed(by: disposeBag)
    }
                     
}
    
