//
//  SearchViewModel.swift
//  td5
//
//  Created by SOUCHET Julie on 18/05/2022.
//

import Foundation

class SearchViewModel {
  func search(_ term: String, completion: @escaping([ITunesSearchResult]) -> ()) {
    guard let url = URL(string: "https://itunes.apple.com/search?term=\(term)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) else {
      print("Music player start error: invalid search param", term)
      return
    }

    Networker<ITunesSearchResponseModel?>.fetch(url) { result in
      guard let data = result else {
        print("iTunes fetch error: no response")
        return
      }

      let songs = data.results.filter({ el in
        el.kind == "song"
      })

      print("Fetched \(songs.count) songs")

      completion(songs)
    }
  }
}

struct ITunesSearchResponseModel: Codable {
  let resultCount: Int
  let results: [ITunesSearchResult]
}

struct ITunesSearchResult: Codable {
  let kind: String?
  let artistName: String
  let artworkUrl60: String?
  let artworkUrl100: String?
  let previewUrl: String?
  let trackName: String?
  let trackPrice: Float?
  let currency: String
}
