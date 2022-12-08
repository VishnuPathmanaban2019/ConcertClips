//
//  FeedViewRepresentable.swift
//  ConcertClips
//
//  Created by Roshan Ram on 11/12/22.
//

import Foundation

import SwiftUI

struct EventFeedViewRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = EventViewController
    
    @ObservedObject var clipsManagerViewModel = ClipsManagerViewModel()
  
    @State var eventName: String
    
    
    func makeUIViewController(context: Context) -> EventViewController {
        // Return MyViewController instance
      print("eventName in representable \(self.eventName)")
      let vc = EventViewController(eventName: eventName)
        return vc
    }
    
    func updateUIViewController(_ uiViewController: EventViewController, context: Context) {
        // Updates the state of the specified view controller with new information from SwiftUI.
    }
}
