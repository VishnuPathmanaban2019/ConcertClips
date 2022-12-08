//
//  EventSectionView.swift
//  ConcertClips
//
//  Created by Siddharth Paratkar on 12/7/22.
//

import SwiftUI

struct EventSectionView: View {
    @State var eventName: String
    @State var clips: [ClipViewModel]
    @ObservedObject var clipsManagerViewModel = ClipsManagerViewModel()
    
    var body: some View {
        let _ = clips = clipsManagerViewModel.clipViewModels.sorted(by: { $0.clip.name < $1.clip.name }).filter ({ $0.clip.name == eventName })
        
        let _ = print("clips: \(clips)")
        
        var allSections = Set<String>()
        let _ = clips.forEach { clip in
            allSections.insert(clip.clip.section)
        }
        VStack {
            ForEach(clips) {clip in
                let _ = print("this section: \(clip.clip.section)")
                let _ = allSections.insert(clip.clip.section)
            }
        }
        
        let _ = print("allSections: \(allSections)")
        
        List(Array(allSections.sorted()), id: \.self) { section in
            NavigationLink {
                EventSectionFeedView(eventName: eventName, section: section)
            } label: {
                Text(section)
            }
        }
    }
}
