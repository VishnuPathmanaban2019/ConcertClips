//
//  UserView.swift
//  ConcertClips
//
//  Created by Vishnu Pathmanaban on 12/7/22.
//

import Foundation

import SwiftUI
import GoogleSignIn

struct UserView: View {
  // 1
  @EnvironmentObject var viewModel: AuthenticationViewModel
  
  // 2
  private let user = GIDSignIn.sharedInstance.currentUser
    
  
  var body: some View {

    NavigationView {
      VStack {
        Spacer()
        HStack {
          // 3
          NetworkImage(url: user?.profile?.imageURL(withDimension: 200))
            .aspectRatio(contentMode: .fit)
            .frame(width: 100, height: 100, alignment: .center)
            .cornerRadius(8)

          VStack(alignment: .leading) {
            Text(user?.profile?.name ?? "")
              .font(.headline)

            Text(user?.profile?.email ?? "")
              .font(.subheadline)
          }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
        .padding()
        
        Spacer()
        
        NavigationLink {
          SavedClipsView()
        } label: {
          Text("My Saved Clips")
        }
        
        Spacer()

        Button(action: viewModel.signOut) {
          Text("Sign Out")
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color(.systemIndigo))
            .cornerRadius(12)
            .padding()
        }
        Spacer()
      }
    }
    .navigationViewStyle(StackNavigationViewStyle())
  }
}

/// A generic view that shows images from the network.
struct NetworkImage: View {
  let url: URL?

  var body: some View {
    if let url = url,
       let data = try? Data(contentsOf: url),
       let uiImage = UIImage(data: data) {
      Image(uiImage: uiImage)
        .resizable()
        .aspectRatio(contentMode: .fit)
    } else {
      Image(systemName: "music.quarternote.3")
        .resizable()
        .aspectRatio(contentMode: .fit)
    }
  }
}
