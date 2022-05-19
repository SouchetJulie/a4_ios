//
//  MusicPlayer.swift
//  td5
//
//  Created by SOUCHET Julie on 19/05/2022.
//

import Foundation
import UIKit
import Kingfisher
import AVKit

extension SearchViewController {
  /// Initializes the music player
  func setupMusicPlayer() {
    // Add music player
    playerViewController.player = AVPlayer()

    // Add background image
    playerViewController.contentOverlayView?.addSubview(trackBgImage)
    // Sizing contraints
    trackBgImage.translatesAutoresizingMaskIntoConstraints = false
    playerViewController.contentOverlayView?.addConstraints([
      NSLayoutConstraint(item: trackBgImage, attribute: .centerX, relatedBy: .equal, toItem: playerViewController.contentOverlayView, attribute: .centerX, multiplier: 1, constant: 0),
      NSLayoutConstraint(item: trackBgImage, attribute: .centerY, relatedBy: .equal, toItem: playerViewController.contentOverlayView, attribute: .centerY, multiplier: 1, constant: 0),
      NSLayoutConstraint(item: trackBgImage, attribute: .width, relatedBy: .equal, toItem: playerViewController.contentOverlayView, attribute: .width, multiplier: 1, constant: 0)
    ])
    trackBgImage.addConstraint(NSLayoutConstraint(item: trackBgImage, attribute: .height, relatedBy: .equal, toItem: trackBgImage, attribute: .width, multiplier: 1, constant: 1))

    // Add title
    playerViewController.contentOverlayView?.addSubview(trackTitleLabel)
    // -- Title style
    trackTitleLabel.textColor = .white
    trackTitleLabel.numberOfLines = 0
    trackTitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    trackTitleLabel.textAlignment = .center
    trackTitleLabel.translatesAutoresizingMaskIntoConstraints = false
    playerViewController.contentOverlayView?.addConstraints([
      NSLayoutConstraint(item: trackTitleLabel, attribute: .centerX, relatedBy: .equal, toItem: playerViewController.contentOverlayView, attribute: .centerX, multiplier: 1, constant: 0),
      NSLayoutConstraint(item: trackTitleLabel, attribute: .top, relatedBy: .equal, toItem: playerViewController.contentOverlayView, attribute: .top, multiplier: 1, constant: 150),
      NSLayoutConstraint(item: trackTitleLabel, attribute: .trailing, relatedBy: .lessThanOrEqual, toItem: playerViewController.contentOverlayView, attribute: .trailing, multiplier: 1, constant: 0)
    ])

    // Add price
    playerViewController.contentOverlayView?.addSubview(trackPriceLabel)
    // -- Price style
    trackPriceLabel.textColor = .white
    trackPriceLabel.numberOfLines = 0
    trackPriceLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    trackPriceLabel.textAlignment = .center
    trackPriceLabel.translatesAutoresizingMaskIntoConstraints = false
    playerViewController.contentOverlayView?.addConstraints([
      NSLayoutConstraint(item: trackPriceLabel, attribute: .centerX, relatedBy: .equal, toItem: playerViewController.contentOverlayView, attribute: .centerX, multiplier: 1, constant: 0),
      NSLayoutConstraint(item: trackPriceLabel, attribute: .bottom, relatedBy: .equal, toItem: playerViewController.contentOverlayView, attribute: .bottom, multiplier: 1, constant: -150),
      NSLayoutConstraint(item: trackPriceLabel, attribute: .trailing, relatedBy: .lessThanOrEqual, toItem: playerViewController.contentOverlayView, attribute: .trailing, multiplier: 1, constant: 0)
    ])
  }

  /// Plays a song
  func showMusicPlayer(_ track: ITunesSearchResult) {
    guard let url = URL(string: track.previewUrl ?? "") else {
      print("Open player error: invalid url", track.previewUrl ?? "<no url>")
      // Show alert
      let dialogMessage = UIAlertController(title: nil, message: "Invalid preview URL", preferredStyle: .alert)
      dialogMessage.addAction(UIAlertAction(title: "Return", style: .cancel))
      self.present(dialogMessage, animated: true, completion: nil)
      return
    }

    // Load track
    let item = AVPlayerItem(url: url)
    playerViewController.player?.replaceCurrentItem(with: item)

    // Add background image if available
    if let imageUrl = URL(string: track.artworkUrl100 ?? track.artworkUrl60 ?? "") {
      trackBgImage.kf.setImage(with: imageUrl)
    }
    trackTitleLabel.text = track.trackName
    trackPriceLabel.text = "\(track.trackPrice?.description ?? "<no price>") \(track.currency)"

    // Show player
    self.present(playerViewController, animated: true) {
      self.playerViewController.player!.play()
    }
  }
}
