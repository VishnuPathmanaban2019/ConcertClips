//
//  LoginView.swift
//  ConcertClips
//
//  Created by Roshan Ram on 12/4/22.
//

import Foundation

import SwiftUI

struct LoginView: View {

  // 1
  @EnvironmentObject var viewModel: AuthenticationViewModel

  var body: some View {
    VStack {
      Spacer()

      // 2
      Image("header_image")
        .resizable()
        .aspectRatio(contentMode: .fit)

      Text("Welcome to ConcertClips!")
        .fontWeight(.black)
        .foregroundColor(Color(.systemIndigo))
        .font(.largeTitle)
        .multilineTextAlignment(.center)

//      Text("<Placeholder text about the app here>")
//        .fontWeight(.light)
//        .multilineTextAlignment(.center)
//        .padding()

      Spacer()

      // 3
      GoogleSignInButton()
        .padding()
        .onTapGesture {
          viewModel.signIn()
        }
    }
  }
}
