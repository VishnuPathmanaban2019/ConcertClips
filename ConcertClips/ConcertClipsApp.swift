//
//  ConcertClipsApp.swift
//  ConcertClips
//
//  Created by Vishnu Pathmanaban on 11/4/22.
//

import Foundation
import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct ConcertClipsApp: App {
    
  @StateObject var viewModel = AuthenticationViewModel() // login authentication
    
  // register app delegate for Firebase setup
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
  var body: some Scene {
    WindowGroup {
      NavigationView {
        ContentView()
              .environmentObject(viewModel) // login authentication view
      }
    }
  }
}
