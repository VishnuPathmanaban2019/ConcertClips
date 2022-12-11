//
//  UploadedView.swift
//  ConcertClips
//
//  Created by Siddharth Paratkar on 11/10/22.
//

import SwiftUI

struct UploadedView: View {
    @State var moveToFeedView : Bool
    @ObservedObject var clipsManagerViewModel = ClipsManagerViewModel()
    var clip: Clip
    @Binding var tabSelection: Int
    @Binding var data: Movie?
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    
    private var concertImageBackground: some View {
        GeometryReader { geometry in
            Image("concert_background_blue")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: geometry.size.width)
        }.background(.black)
    }
    
    var body: some View {
        
        concertImageBackground.overlay(
            VStack {
                        NavigationLink(destination:  ContentView().environmentObject(viewModel).navigationBarBackButtonHidden(true), isActive: $moveToFeedView) {
                            EmptyView()
                        }

                Text("Clip Uploaded!").fontWeight(.bold).foregroundColor(.white).onAppear() {
                            clipsManagerViewModel.add(clip)
                            data = nil
                            self.tabSelection = 0
                        }
                
                        Button(action: {
                            self.moveToFeedView = true
                
                        }) {
                            Text("Go to Feed")
                                .foregroundColor(.black)
                                .padding()
                //                            .frame(maxWidth: .infinity)
                                .background(Color(red: 0.4627, green: 0.8392, blue: 1.0))
                                .cornerRadius(12)
                                .padding()
                        }
            }
        )
    }
}
