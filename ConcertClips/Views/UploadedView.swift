//
//  UploadedView.swift
//  ConcertClips
//
//  Created by Siddharth Paratkar on 11/10/22.
//

import SwiftUI

struct UploadedView: View {
  @ObservedObject var clipsManagerViewModel = ClipsManagerViewModel()
  @State var clip: Clip
  
  init(clip: Clip) {
    self.clip = clip
  }
  
  var body: some View {
    Text("Clip Uploaded!").onAppear() {
      clipsManagerViewModel.add(clip)
    }
    NavigationLink {
      ContentView().navigationBarBackButtonHidden(true)
    } label: {
      Text("Go to Home")
    }
  }
}
