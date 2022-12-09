//
//  EventSectionFeedViewRepresentable.swift
//  ConcertClips
//
//  Created by Siddharth Paratkar on 12/7/22.
//

import Foundation
import SwiftUI

struct EventSectionFeedViewRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = EventSectionViewController
    
    @ObservedObject var clipsManagerViewModel = ClipsManagerViewModel()
    
    @State var eventName: String
    @State var section: String
    
    func makeUIViewController(context: Context) -> EventSectionViewController {
        // Return MyViewController instance
        let vc = EventSectionViewController(eventName: eventName, section: section)
        return vc
    }
    
    func updateUIViewController(_ uiViewController: EventSectionViewController, context: Context) {
        // Updates the state of the specified view controller with new information from SwiftUI.
    }
}

