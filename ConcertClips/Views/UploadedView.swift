//
//  UploadedView.swift
//  ConcertClips
//
//  Created by Siddharth Paratkar on 11/10/22.
//

import SwiftUI

struct UploadedView: View {
  @ObservedObject var clipsManagerViewModel = ClipsManagerViewModel()
  var clip: Clip
  @Binding var isShowingNewClipView: Bool
  @Binding var tabSelection: Int
  
//  init(clip: Clip, isShowingNewClipView: Bool) {
//    self.clip = clip
//    self.isShowingNewClipView = isShowingNewClipView
//  }
  
  var body: some View {
    Text("Clip Uploaded!").onAppear() {
      clipsManagerViewModel.add(clip)
    }
    Button {
//      ContentView().navigationBarBackButtonHidden(true)
      let _ = isShowingNewClipView = false
      self.tabSelection = 1
    } label: {
      Text("Go to Home")
    }
  }
}
