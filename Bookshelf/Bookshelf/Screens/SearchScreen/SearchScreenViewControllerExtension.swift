//
//  SearchScreenViewControllerExtension.swift
//  Bookshelf
//
//  Created by Anastasia on 06.02.2023.
//

import UIKit
import RxSwift

extension SearchScreenViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.book.book.value?.title.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchScreenTableViewCell.cellId, for: indexPath) as? SearchScreenTableViewCell else {
            return UITableViewCell()
        }
        let disposeBag: DisposeBag = .init()
        viewModel.title.asObservable().bind(onNext: { title in
            cell.bookName.text = title
        }).disposed(by: disposeBag)
        viewModel.author.asObservable().bind(onNext: { author in
            cell.bookAuthor.text = author
        }).disposed(by: disposeBag)
        viewModel.image.asObservable().bind(onNext: { image in
            cell.bookCover.image = image
        }).disposed(by: disposeBag)
        return cell
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        self.viewModel.setData()
    }
    
}
