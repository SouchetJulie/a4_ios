//
//  MusicViewModel.swift
//  td6
//
//  Created by SOUCHET Julie on 19/05/2022.
//

import Foundation

class MusicViewModel: ObservableObject {
  @Published var list: [MusicModel] = []

  func search(_ term: String) -> () {
    guard let url = URL(string: "https://itunes.apple.com/search?term=\(term)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) else {
      print("Music player start error: invalid search param", term)
      return
    }

    Networker<ITunesSearchResponseModel?>.fetch(url) { result in
      guard let data = result else {
        print("iTunes fetch error: no response")
        return
      }

      let songs: [MusicModel] = data.results
        .filter({ el in
          el.kind == "song"
        })
        .map { song in
          MusicModel(track: song)
        }

      print("Fetched \(songs.count) songs")

      DispatchQueue.main.async {
        self.list = songs
      }
    }
  }
}
