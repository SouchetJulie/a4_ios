//
//  TableView.swift
//  td5
//
//  Created by SOUCHET Julie on 18/05/2022.
//

import Foundation
import UIKit
import Kingfisher
import AVKit

extension SearchViewController: UITableViewDelegate {
  // Ouvre la vue de lecture
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    // TODO move to separate file
    let track = self.tracks[indexPath.row]

    guard let url = URL(string: track.previewUrl ?? "") else {
      print("Open player error: invalid url", self.tracks[indexPath.row].previewUrl ?? "<no url>")
      return
    }

    print(">> Go to: \(track.trackName ?? "<no track name>")")

    let player = AVPlayer(url: url)

    // Add music player
    let playerViewController = AVPlayerViewController() // creating a player view controller
    playerViewController.player = player

    // Add background image if available
    // TODO to fix
    if let imageUrl = URL(string: track.artworkUrl100 ?? track.artworkUrl60 ?? "") {
      let image = UIImageView()
      image.kf.setImage(with: imageUrl)
      playerViewController.contentOverlayView?.addSubview(image)
    } else {
      print("No background available")
    }

    // Show player
    self.present(playerViewController, animated: true) {
      playerViewController.player!.play()
    }
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

    if let artworkUrl = URL(string: track.artworkUrl60 ?? "") {
      cell.trackImage.kf.setImage(with: artworkUrl)
    } else {
      print("No artwork for track n°\(indexPath.row)")
    }

    return cell
  }
}
