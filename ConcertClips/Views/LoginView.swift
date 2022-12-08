//
//  LoginView.swift
//  ConcertClips
//
//  Created by Vishnu Pathmanaban on 12/7/22.
//

import Foundation

import SwiftUI

struct LoginView: View {

  // 1
  @EnvironmentObject var viewModel: AuthenticationViewModel

  var body: some View {
    VStack {
      Spacer()
      
      Image("header_image")
        .resizable()
        .aspectRatio(contentMode: .fit)

      Text("ConcertClips")
        .fontWeight(.black)
        .foregroundColor(Color(.black))
        .font(.largeTitle)
        .multilineTextAlignment(.center)

      Text("Login with Google")
        .fontWeight(.light)
        .multilineTextAlignment(.center)
        .padding()
      
      GoogleSignInButton()
        .padding()
        .onTapGesture {
          viewModel.signIn()
        }
      
      Spacer()

    }
  }
}
