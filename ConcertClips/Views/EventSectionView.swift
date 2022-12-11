//
//  EventSectionView.swift
//  ConcertClips
//
//  Created by Siddharth Paratkar on 12/7/22.
//

import SwiftUI

struct EventSectionView: View {
    @State var eventName: String
    @State var clips: [Clip]
    
    
    private var concertImageBackground: some View {
        GeometryReader { geometry in
            Image("no_clips_yet_v1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: geometry.size.width)
        }
    }
    
    var body: some View {
        var allSections = Set<String>()
        let _ = clips.forEach { clip in
            if (clip.event == eventName) {
               allSections.insert(clip.section)
            }
        }
        
        concertImageBackground.overlay(
            List(Array(allSections.sorted()), id: \.self) { section in
                NavigationLink {
                    EventSectionFeedView(eventName: eventName, section: section).background(.black)
                } label: {
                    Text(section)
                }
            }
        ).background(.black)
    }
}
