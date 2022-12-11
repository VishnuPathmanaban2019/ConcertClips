//
//  ContentView.swift
//  ConcertClips
//
//  Created by Vishnu Pathmanaban on 11/4/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    var body: some View {
        
        VStack {
            switch viewModel.state {
            case .signedIn: LoggedInView()
            case .signedInFull: AppView()
            case .signedOut: LoginView()
            }
        }.background(Image("concert_background_blue"))
         .ignoresSafeArea(.all)
    }
}
