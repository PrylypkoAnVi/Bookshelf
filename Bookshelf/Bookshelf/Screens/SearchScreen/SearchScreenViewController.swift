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
    internal var mainView: SearchScreenView {
        guard let mainView = self.view as? SearchScreenView else {fatalError("View Error")}
        return mainView
    }
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
        searchBar?.delegate = self
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.register(SearchScreenTableViewCell.self, forCellReuseIdentifier: SearchScreenTableViewCell.cellId)
        addBinding()
    }
    
    deinit {
        print("Deinit: \(Self.self)")
    }
 
    private func addBinding() {
        searchBar?.searchTextField.rx.text
            .orEmpty
            .bind(onNext: { smthn in
                self.viewModel.searchTextObservable.accept(smthn.lowercased().replacingOccurrences(of: " ", with: "+"))
                print(self.viewModel.searchTextObservable.value.map{$0})
            }).disposed(by: disposeBag)
    }
                     
}
    
