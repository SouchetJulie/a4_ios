//
//  PlayerView.swift
//  td6
//
//  Created by SOUCHET Julie on 19/05/2022.
//

import SwiftUI
import Foundation
import AVKit

struct PlayerView: View {
  static public var player = AVPlayer()
  
  public var track: ITunesSearchResult
  @State var showAlert = false


  var body: some View {
    NavigationView {
      VStack {
        HStack {
          Text(track.trackName ?? "")
            .font(.system(size: 20, weight: .bold, design: .rounded))
          Text("by " + track.artistName)
        }

        if let url = URL(string: track.previewUrl ?? "") {

          VideoPlayer(player: PlayerView.player)
            .onAppear {
              PlayerView.player.replaceCurrentItem(with: AVPlayerItem(url: url))
              PlayerView.player.play()
            }
            .onDisappear {
              PlayerView.player.pause()
            }
            .overlay {
              AsyncImage(url: URL(string: track.artworkUrl100 ?? "")) { phase in
                switch phase {
                  case .empty:
                    ProgressView()
                      .progressViewStyle(.circular)

                  case .success(let image):
                    image
                      .resizable()
                      .aspectRatio(contentMode: .fill)

                  case .failure:
                    Text("Error")
                      .foregroundColor(.red)

                  @unknown default:
                    Text("Unknown error")
                }
              }
            }

        } else {
          Text("Invalid url")
            .foregroundColor(.red)
        }
      }
      .navigationTitle("Now playing...")

    }
  }

}


