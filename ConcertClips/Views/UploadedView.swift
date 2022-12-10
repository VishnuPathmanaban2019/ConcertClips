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
    
    var body: some View {
        Text("Clip Uploaded!").onAppear() {
            clipsManagerViewModel.add(clip)
            data = nil
            self.tabSelection = 0
        }
//        NavigationLink {
//            ContentView().environmentObject(viewModel).navigationBarBackButtonHidden(true)
//        } label: {
//            Text("Go to Feed")
//        }
        

        //
        NavigationLink(destination:  ContentView().environmentObject(viewModel).navigationBarBackButtonHidden(true), isActive: $moveToFeedView) { EmptyView() }

        Button(action: {
            self.moveToFeedView = true
            
        }) {
            Text("Go to Feed")
                .foregroundColor(.white)
                .padding()
//                            .frame(maxWidth: .infinity)
                .background(Color(.black))
                .cornerRadius(12)
                .padding()
        }
    }
}
