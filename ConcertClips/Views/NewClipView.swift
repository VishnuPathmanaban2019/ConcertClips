//
//  NewClipView.swift
//  ConcertClips
//
//  Created by Siddharth Paratkar on 11/5/22.
//

import SwiftUI

struct NewClipView: View {
  @StateObject var clipsManagerViewModel = ClipsManagerViewModel()
  var downloadURL: String
  @Binding var tabSelection: Int
  @Binding var data: Movie?
  
//  init(downloadURL: String, isShowingNewClipView: Bool) {
//    self.downloadURL = downloadURL
//    self.isShowingNewClipView = isShowingNewClipView
//  }

  @State private var name = ""
  @State private var event = ""
  @State private var user = ""
  @State private var section = ""
  @State private var song = ""
  @State private var likes = 0
  @State private var isActive = false
  @State private var popupTagsPresented = false

  var body: some View {
    VStack {
      Text("New Clip")
        .font(.title)
        .fontWeight(.bold)
      Form {
        TextField("Name", text: $name)
        
        TextField("Event", text: $event)
        .onChange(of: event, perform: { newTag in
          if (event != "") {
            popupTagsPresented = true
          }
          else {
            popupTagsPresented = false
          }
        })
        if (popupTagsPresented) {
          let filteredMatches = ["some stuff", "somethingElse"] //TODO - actually filter from overall event repo
          Menu {
            ForEach(filteredMatches, id: \.self) { suggestion in
              Button{
                event = suggestion
                // reset textfield to nil?
              } label: {
                Label(suggestion, systemImage: "someIcon")
              }
              .buttonStyle(.borderless)
            }
          } label: {
               Text("Select an Event")
//               Image(systemName: "tag.circle")
          }
        }
        
        TextField("User", text: $user)
        TextField("Section", text: $section)
        TextField("Song", text: $song)
      }
      if self.isValidClip() {
        let _ = print("Trying to add clip")
        let clip = Clip(name: name, event: event, user: user, section: section, song: song, likes: likes, downloadURL: downloadURL)
        NavigationLink {
          UploadedView(clip: clip, tabSelection: $tabSelection, data: $data).navigationBarBackButtonHidden(true)
          let _ = clearFields()
        } label: {
          Text("Add Clip")
        }
      }
    }
  }
  

  private func isValidClip() -> Bool {
    if name.isEmpty { return false }
    if event.isEmpty { return false }
    if user.isEmpty { return false }
    if section.isEmpty { return false }
    if song.isEmpty { return false }
    return true
  }
  
  private func clearFields() {
    name = ""
    event = ""
    user = ""
    section = ""
    song = ""
  }
  
}
