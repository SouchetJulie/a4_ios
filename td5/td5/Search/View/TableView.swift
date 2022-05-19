//
//  TableView.swift
//  td5
//
//  Created by SOUCHET Julie on 18/05/2022.
//

import Foundation
import UIKit
import Kingfisher

extension SearchViewController: UITableViewDelegate {
  // Open music player on click
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.showMusicPlayer(self.tracks[indexPath.row])
  }
}

extension SearchViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    tracks.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath) as! SearchResultCell

    let track = tracks[indexPath.row]
    cell.artistLabel.text = track.artistName
    cell.trackLabel.text = track.trackName ?? "<no title>"
    cell.priceLabel.text = "\(track.trackPrice?.description ?? "<no price>") \(track.currency)"

    if let artworkUrl = URL(string: track.artworkUrl60 ?? "") {
      cell.trackImage.kf.setImage(with: artworkUrl)
    } else {
      print("No artwork for track n°\(indexPath.row)")
    }

    return cell
  }
}
