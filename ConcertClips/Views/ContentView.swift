//
//  ContentView.swift
//  ConcertClips
//
//  Created by Vishnu Pathmanaban on 11/4/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
  @State private var tabSelection = 0
  
  var body: some View {
    TabView(selection: $tabSelection) {
        FeedView().ignoresSafeArea()
      .tabItem {
          Image(systemName: "books.vertical")
          Text("Feed")
      }.tag(0)
      
      LibraryView()
      .tabItem {
          Image(systemName: "books.vertical")
          Text("Library")
      }.tag(1)

      ClipSelectView(tabSelection: $tabSelection)
      .tabItem {
          Image(systemName: "rectangle.stack.badge.plus")
          Text("New Clip")
      }.tag(2)
      
      SearchView()
        .tabItem {
            Image(systemName: "magnifyingglass")
            Text("Search")
        }.tag(3)
    }
  }
}
