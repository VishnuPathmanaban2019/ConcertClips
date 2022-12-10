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
                }.tag(1) //.background(Image("concert_background_blue").resizable())
            
            ClipSelectView(tabSelection: $tabSelection)
                .tabItem {
                    Image(systemName: "rectangle.stack.badge.plus")
                    Text("Upload")
                }.background(.black)
                .background(Image("concert_background_blue"))
                .tag(2)
            
            UserView(moveToSavedClipsView: false)
                .tabItem {
                    Image(systemName: "person")
                    Text("User")
                }.background(.black)
                .background(Image("concert_background_blue"))
                .tag(3)
        }
        .onAppear() {
            UITabBar.appearance().barTintColor = .black
            UITabBar.appearance().backgroundColor = .black
        }
    }
}
