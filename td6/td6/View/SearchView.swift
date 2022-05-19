//
//  ContentView.swift
//  td6
//
//  Created by SOUCHET Julie on 19/05/2022.
//

import SwiftUI

struct SearchView: View {
  @ObservedObject private var musicViewModel = MusicViewModel()
  @State private var text = ""

  var body: some View {
    NavigationView {
      VStack {
        if musicViewModel.list.isEmpty {
          Text("Search some music! 🔍")
        } else {
          // Result list
          List(musicViewModel.list, id: \.id) { element in

            // Result item
            NavigationLink(destination: PlayerView(track: element.track)) {
              HStack {
                AsyncImage(url: URL(string: element.track.artworkUrl60 ?? ""))
                  .frame(width: 60, height: 60, alignment: .center)

                // Track title
                VStack {
                  Text(element.track.trackName ?? "")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                  Text(element.track.artistName)
                    .italic()
                    .frame(maxWidth: .infinity, alignment: .leading)
                }

                Spacer()

                // Track price
                Text(element.track.trackPrice?.description ?? "")
                  .font(.system(size: 15, weight: .light, design: .rounded))
                Text(element.track.currency)
                  .font(.system(size: 15, weight: .thin, design: .rounded))
              }
            }

          }
        }
      }
      // Search bar
      .searchable(text: $text, prompt: "Search...")
      .onChange(of: text) { text in
        musicViewModel.search(text)
      }

      .navigationTitle("🎶 myTunes")
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      SearchView()
        .preferredColorScheme(.dark)
        .previewDevice("iPhone 11")
    }
  }
}




