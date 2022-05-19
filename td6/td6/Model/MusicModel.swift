//
//  MusicModel.swift
//  td6
//
//  Created by SOUCHET Julie on 19/05/2022.
//

import Foundation

struct MusicModel {
  let track: ITunesSearchResult
  let id: UUID = UUID()
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
