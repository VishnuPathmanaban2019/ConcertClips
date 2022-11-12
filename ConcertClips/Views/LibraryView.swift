//
//  LibraryView.swift
//  ConcertClips
//
//  Created by Siddharth Paratkar on 11/5/22.
//

import SwiftUI

struct LibraryView: View {
  
  // @EnvironmentObject var library: Library
  @ObservedObject var clipsManagerViewModel = ClipsManagerViewModel()
  
  var body: some View {
    NavigationView {
      List{
        let clipViewModels = clipsManagerViewModel.clipViewModels.sorted(by: { $0.clip < $1.clip })
        let _ = print("LibraryView: \(clipViewModels)")
          
        ForEach(clipViewModels) { clipViewModel in
          VStack {
            Text(clipViewModel.clip.name)
              .font(.title)
              .fontWeight(.black)
              .padding([.top], 40)
            Text(clipViewModel.clip.event)
              .font(.title)
              .fontWeight(.black)
              .padding([.top], 40)
            Text(clipViewModel.clip.user)
              .font(.title)
              .fontWeight(.black)
              .padding([.top], 40)
            Text(clipViewModel.clip.section)
              .font(.title)
              .fontWeight(.black)
              .padding([.top], 40)
            Text(clipViewModel.clip.song)
              .font(.title)
              .fontWeight(.black)
              .padding([.top], 40)
          }
        }
      }.navigationBarTitle("Library")
    }
  }
  
}
