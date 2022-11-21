//
//  ContentView.swift
//  ConcertClips
//
//  Created by Vishnu Pathmanaban on 11/4/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
  @State private var tabSelection = 1
  
  var body: some View {
    
    TabView(selection: $tabSelection) {
        FeedView().ignoresSafeArea()
      .tabItem {
          Image(systemName: "books.vertical")
          Text("Feed")
      }
      
      LibraryView()
      .tabItem {
          Image(systemName: "books.vertical")
          Text("Library of Content")
      }

      ClipSelectView(tabSelection: $tabSelection)
      .tabItem {
          Image(systemName: "rectangle.stack.badge.plus")
          Text("New Clip")
      }
    }
  // But since I am using Firebase, do I really need this anymore?
  //    .environmentObject(libraryViewModel)
  }
}
