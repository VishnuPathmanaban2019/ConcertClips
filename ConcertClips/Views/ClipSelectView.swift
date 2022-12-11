//
//  ClipSelectionView.swift
//  ConcertClips
//
//  Created by Siddharth Paratkar on 11/6/22.
//
//  Adapted from https://www.youtube.com/watch?v=crULPMS7Uxs

import SwiftUI
import PhotosUI
import AVKit

struct ClipSelectView: View {
    @State var selectedVideos: [PhotosPickerItem] = []
    @State var showNewClipView: Bool = false
    @State var downloadURL: String = ""
    @State var confirmText: String = "Upload clip"
    @Binding var tabSelection: Int
    @State var data: Movie?
    
    @ObservedObject var clipSelectViewModel = ClipSelectViewModel()
    
    var body: some View {
        ZStack { // rram
//            Image("concert_background_blue").scaledToFit()
            VStack {
                if let data = data {
                    let player = AVPlayer(url: data.url)
                    VideoPlayer(player: player)
                    if showNewClipView {
                        NewClipView(downloadURL: downloadURL, tabSelection: $tabSelection, data: $data)
                    } else {
                        let _ = confirmText = "Upload clip"
                        Button(action: {
                            Task {
                                downloadURL = try await clipSelectViewModel.upload(file: data.url)
                                showNewClipView = true
                            }
                            confirmText = "Click again to confirm"
                        }) {
                            Text(confirmText)
                        }
                    }
                } else {
                    PhotosPicker(
                        selection: $selectedVideos,
                        maxSelectionCount: 1,
                        matching: .videos
                    ) {
                        Text("Pick a clip to upload")
                            .foregroundColor(.black)
                            .padding()
//                            .frame(maxWidth: )
                            .background(Color(red: 0.4627, green: 0.8392, blue: 1.0))
                            .cornerRadius(20)
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 20)
//                                    .inset(by: 5) // inset value should be same as lineWidth in .stroke
////                                    .stroke(.blue, lineWidth: 5)
//                            )
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
//        .frame(width: 800, height: 800)
//        .background(.black)
//        .background(Image("concert_background_blue"))
//        .edgesIgnoringSafeArea(.all)
    }
}
