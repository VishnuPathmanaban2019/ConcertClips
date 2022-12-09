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
    
    var body: some View {
        var allSections = Set<String>()
        let _ = clips.forEach { clip in
            if (clip.event == eventName) {
               allSections.insert(clip.section)
            }
        }
        
        List(Array(allSections.sorted()), id: \.self) { section in
            NavigationLink {
                EventSectionFeedView(eventName: eventName, section: section)
            } label: {
                Text(section)
            }
        }
    }
}
