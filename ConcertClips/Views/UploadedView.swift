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
  @Binding var tabSelection: Int
  @Binding var data: Movie?
//  @Published var state: SignInState = .signedIn
  
//  init(clip: Clip, isShowingNewClipView: Bool) {
//    self.clip = clip
//    self.isShowingNewClipView = isShowingNewClipView
//  }
  
  var body: some View {
    Text("Clip Uploaded!").onAppear() {
      clipsManagerViewModel.add(clip)
      data = nil
      self.tabSelection = 1
    }
    NavigationLink {
//        self.state =  // rram
      ContentView().navigationBarBackButtonHidden(true)
    } label: {
      Text("Go to Home")
    }
  }
}
