//
//  EventSectionFeedView.swift
//  ConcertClips
//
//  Created by Siddharth Paratkar on 12/7/22.
//

import SwiftUI

struct EventSectionFeedView: View {
    @State var eventName: String
    @State var section: String
    
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
                Text("\(eventName) | Section: \(section)").fontWeight(.bold).foregroundColor(.white).padding(.top)
                EventSectionFeedViewRepresentable(eventName: eventName, section: section).ignoresSafeArea()
            }
        )
    }
}
