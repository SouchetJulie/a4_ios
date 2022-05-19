//
//  MusicPlayerViewController.swift
//  td5
//
//  Created by SOUCHET Julie on 18/05/2022.
//

import UIKit
import AVKit

class SearchViewController: UIViewController {

  var tracks: [ITunesSearchResult] = []
  let service = SearchViewModel()
  let searchController = UISearchController(searchResultsController: nil)
  let playerViewController = AVPlayerViewController()
  let trackTitleLabel = UILabel()
  let trackPriceLabel = UILabel()
  let trackBgImage = UIImageView()

  @IBOutlet weak var tableView: UITableView!


  override func viewDidLoad() {
    super.viewDidLoad()
    title = "🎵 myTunes 🎶"

    // Table view
    tableView.delegate = self
    tableView.dataSource = self

    // Search bar
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    definesPresentationContext = true
    tableView.tableHeaderView = searchController.searchBar

    // Music player
    setupMusicPlayer()
  }

  func fetchData(_ term: String) {
    service.search(term) { results in
      DispatchQueue.main.async {
        self.tracks = results
        self.tableView.reloadData()
      }
    }
  }
}


