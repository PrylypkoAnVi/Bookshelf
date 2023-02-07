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
        return viewModel.bookManager.book.value?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchScreenTableViewCell.cellId, for: indexPath) as? SearchScreenTableViewCell,
              let data = viewModel.bookManager.book.value?[indexPath.row]
        else {
            return UITableViewCell()
        }
        cell.setData(data)
        return cell
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
}
