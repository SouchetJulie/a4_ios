//
//  SearchBarController.swift
//  td5
//
//  Created by SOUCHET Julie on 18/05/2022.
//

import Foundation
import UIKit

extension SearchViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    guard let term = searchController.searchBar.text, term != "" else { // nothing to search
      self.tracks = []
      self.tableView.reloadData()
      return
    }

    self.fetchData(term)
  }
}
