//
//  SearchScreenViewControllerExtension.swift
//  Bookshelf
//
//  Created by Anastasia on 06.02.2023.
//

import UIKit
import RxSwift
import RxCocoa

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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let data = viewModel.bookManager.book.value?[indexPath.row] else { return }
        let bookScreenDestination = BookScreenDestination(bookFound: data)
        resolve(Router.self).route(to: bookScreenDestination)
    }
}
