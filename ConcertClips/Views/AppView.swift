//
//  AppView.swift
//  ConcertClips
//
//  Created by Vishnu Pathmanaban on 12/7/22.
//

import SwiftUI
import CoreData

struct AppView: View {
    @State private var tabSelection = 0
    
    var body: some View {
        TabView(selection: $tabSelection) {
            FeedView().ignoresSafeArea()
                .tabItem {
                    Image(systemName: "rectangle.stack")
                    Text("Feed")
                }.tag(0)
            
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                } //.background(Image("concert_background_blue").resizable()).tag(1)
            
            ClipSelectView(tabSelection: $tabSelection)
                .tabItem {
                    Image(systemName: "rectangle.stack.badge.plus")
                    Text("Upload")
                }.tag(2)
            
            UserView(moveToSavedClipsView: false)
                .tabItem {
                    Image(systemName: "person")
                    Text("User")
                }.tag(3)
        }.onAppear() {
            UITabBar.appearance().barTintColor = .white
        }
    }
}
