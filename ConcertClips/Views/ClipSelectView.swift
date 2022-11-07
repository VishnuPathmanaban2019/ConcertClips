//
//  ClipSelectionView.swift
//  ConcertClips
//
//  Created by Siddharth Paratkar on 11/6/22.
//
// Adapted from https://www.youtube.com/watch?v=crULPMS7Uxs

import SwiftUI
import PhotosUI
import AVKit

struct ClipSelectView: View {
  @State var selectedVideos: [PhotosPickerItem] = []
  @State var data: Movie?
  
  var body: some View {
    VStack {
      if let data = data {
        let player = AVPlayer(url: data.url)
        VideoPlayer(player: player)
        // confirm button -> goes to newclipview for metadata input by user
        // also on confirm, we will send url to viewmodel to be updated into firebase storage (happens first)
      } else {
        Spacer()
        PhotosPicker(
          selection: $selectedVideos,
          maxSelectionCount: 1,
          matching: .videos
        ) {
          Text("Pick Clip to Upload")
        }
        .onChange(of: selectedVideos) { newVideo in
          guard let item = selectedVideos.first else {
            return
          }
          let _ = print("\(selectedVideos)")
          item.loadTransferable(type: Movie.self) { result in
            switch result {
            case .success(let data):
              if let data = data {
                self.data = data
              } else {
                print("Error with nil data")
              }
            case .failure (let failure):
              fatalError("\(failure)")
            }
          }
        }
      }
    }
  }
}

struct ClipSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ClipSelectView()
    }
}
