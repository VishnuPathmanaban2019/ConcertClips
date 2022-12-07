//
//  HomeView.swift
//  ConcertClips
//
//  Created by Roshan Ram on 12/4/22.
//

import Foundation

import SwiftUI
import GoogleSignIn

struct HomeView: View {
  // 1
  @EnvironmentObject var viewModel: AuthenticationViewModel
  
  // 2
  private let user = GIDSignIn.sharedInstance.currentUser
    
  
  var body: some View {
//
////    let _ = print("current user: \(user)")
//
//    NavigationView {
//      VStack {
//        HStack {
//          // 3
//          NetworkImage(url: user?.profile?.imageURL(withDimension: 200))
//            .aspectRatio(contentMode: .fit)
//            .frame(width: 100, height: 100, alignment: .center)
//            .cornerRadius(8)
//
//          VStack(alignment: .leading) {
//            Text(user?.profile?.name ?? "")
//              .font(.headline)
//
//            Text(user?.profile?.email ?? "")
//              .font(.subheadline)
//          }
//
//          Spacer()
//        }
//        .padding()
//        .frame(maxWidth: .infinity)
//        .background(Color(.secondarySystemBackground))
//        .cornerRadius(12)
//        .padding()
//
//
        Spacer().onAppear() {
            viewModel.state = .signedInFull
        }
//
//          NavigationLink {
//
//              AppView().navigationBarBackButtonHidden(true).environmentObject(viewModel)
//          } label: {
//              Text("Go to Feed").font(.system(size: 42))
//          }
//
//        Spacer()
//
//        // 4
//        Button(action: viewModel.signOut) {
//          Text("Sign out")
//            .foregroundColor(.white)
//            .padding()
//            .frame(maxWidth: .infinity)
//            .background(Color(.systemIndigo))
//            .cornerRadius(12)
//            .padding()
//        }
//      }
//    }
//    .navigationViewStyle(StackNavigationViewStyle())
//  }
}
//
///// A generic view that shows images from the network.
//struct NetworkImage: View {
//  let url: URL?
//
//  var body: some View {
//    if let url = url,
//       let data = try? Data(contentsOf: url),
//       let uiImage = UIImage(data: data) {
//      Image(uiImage: uiImage)
//        .resizable()
//        .aspectRatio(contentMode: .fit)
//    } else {
//      Image(systemName: "music.quarternote.3")
//        .resizable()
//        .aspectRatio(contentMode: .fit)
//    }
//  }
}
