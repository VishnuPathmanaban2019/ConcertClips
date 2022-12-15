//
//  EventDateView.swift
//  ConcertClips
//
//  Created by Siddharth Paratkar on 12/14/22.
//

import SwiftUI

import SwiftUI

struct EventDateView: View {
    @State var moveToFeedView : Bool
    @State var eventName: String
    
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
                Button(action: {
                    self.moveToFeedView = true
                    
                }) {
                    Text("Sort Clips By Date")
                        .foregroundColor(.black)
                        .padding()
                        .background(Color(red: 0.4627, green: 0.8392, blue: 1.0))
                        .cornerRadius(12)
                        .padding()
                }
                
                NavigationLink(destination: EventDateFeedView(eventName: eventName).background(.black), isActive: $moveToFeedView) {
                    EmptyView()
                }
            }
        )
    }
}
