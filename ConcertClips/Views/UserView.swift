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
    @State var moveToSavedClipsView: Bool
    @EnvironmentObject var viewModel: AuthenticationViewModel
    private let user = GIDSignIn.sharedInstance.currentUser
    
    
    private var concertImageBackground: some View {
        GeometryReader { geometry in
            Image("concert_image_2")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
                .frame(width: geometry.size.width)
        }
    }
    
//        .background(Image("concert_view_of_event").resizable())
    
    var body: some View {
        
        NavigationView {
            concertImageBackground.overlay(
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
                    
                    //                    NavigationLink(destination: SavedClipsView(), label: {
                    //                        Button(action: {}, label: {
                    //                            Text("My Saved Clips")
                    //                        })
                    //                    })
                    
                    NavigationLink(destination: SavedClipsView(), isActive: $moveToSavedClipsView) { EmptyView() }
                    
                    

                    Button(action: {
                        self.moveToSavedClipsView = true
                        
                    }) {
                        Text("My Saved Clips")
//                            .font(.largeTitle)
//                            .fontWeight(.ultraLight)
                            .foregroundColor(.white)
                            .padding()
//                            .frame(maxWidth: .infinity)
                            .background(Color(.black))
                            .cornerRadius(12)
                            .padding()
                    }
                    

                    
//                    NavigationLink(destination: SavedClipsView()) {
//                    }
//                    } label: {
//                        Text("My Saved Clips")
//                    }
                    //.buttonStyle(PlainButtonStyle())
                    //.buttonStyle(ButtonStyle3D(background: Color.black))
                    
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
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

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
