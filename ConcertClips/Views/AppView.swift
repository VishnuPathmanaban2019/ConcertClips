//
//  AppView.swift
//  ConcertClips
//
//  Created by Roshan Ram on 12/4/22.
//

import SwiftUI
import CoreData
import GoogleSignIn


struct AppView: View {
  @State private var tabSelection = 1
  @EnvironmentObject var viewModel: AuthenticationViewModel
    
    
    
//  @State viewModel.state = .signedInFull
//  @Published var state: SignInState = .signedIn
//    viewModel.state = .signedInFull
        
  private let user = GIDSignIn.sharedInstance.currentUser

  
  var body: some View {
      
//          let _ = viewModel.state = .signedInFull
          TabView(selection: $tabSelection) {
              FeedView().ignoresSafeArea()
            .tabItem {
                Image(systemName: "books.vertical")
                Text("Feed")
//                Text(user?.profile?.name ?? "")
            }.tag(1)
            
            LibraryView()
            .tabItem {
                Image(systemName: "books.vertical")
                Text("Library of Content")
            }.tag(2)

            ClipSelectView(tabSelection: $tabSelection)
            .tabItem {
                Image(systemName: "rectangle.stack.badge.plus")
                Text("New Clip")
            }.tag(3)

    }
  }
}
