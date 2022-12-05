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
  @EnvironmentObject var viewModel: AuthenticationViewModel
  
  var body: some View {
      
      switch viewModel.state {
        case .signedIn: HomeView()
        case .signedOut: LoginView()

    }
  }
}
