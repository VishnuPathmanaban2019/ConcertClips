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
  @State var showNewClipView: Bool = false
  @State var downloadURL: String = ""
  
  @ObservedObject var clipSelectViewModel = ClipSelectViewModel()
  
  var body: some View {
    VStack {
      if let data = data {
        let player = AVPlayer(url: data.url)
        VideoPlayer(player: player)
        if showNewClipView {
          NewClipView(downloadURL: downloadURL)
        } else {
          Button(action: {
            let downloadURL = clipSelectViewModel.upload(file: data.url)
            self.showNewClipView = true
          }) {
            Text("Confirm Upload")
          }
        }
      } else {
//        Spacer()
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
