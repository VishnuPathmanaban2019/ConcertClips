//
//  EventDateFeedView.swift
//  ConcertClips
//
//  Created by Siddharth Paratkar on 12/14/22.
//

import SwiftUI

struct EventDateFeedView: View {
    @State var eventName: String
    
    private var concertImageBackground: some View {
        GeometryReader { geometry in
            Image("no_clips_yet_v1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: geometry.size.width)
        }
    }
    
    var body: some View {
        concertImageBackground.overlay(
            VStack {
                Text("\(eventName) | Sorted By Date").fontWeight(.bold).foregroundColor(.white).padding(.top)
                EventDateFeedViewRepresentable(eventName: eventName).ignoresSafeArea()
            }
        )
    }
}
