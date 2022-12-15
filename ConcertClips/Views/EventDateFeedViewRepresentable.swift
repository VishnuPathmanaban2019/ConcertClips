//
//  EventDateFeedViewRepresentable.swift
//  ConcertClips
//
//  Created by Siddharth Paratkar on 12/14/22.
//

import Foundation
import SwiftUI

struct EventDateFeedViewRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = EventDateViewController
    
    @ObservedObject var clipsManagerViewModel = ClipsManagerViewModel()
    
    @State var eventName: String
    
    func makeUIViewController(context: Context) -> EventDateViewController {
        // Return MyViewController instance
        let vc = EventDateViewController(eventName: eventName)
        return vc
    }
    
    func updateUIViewController(_ uiViewController: EventDateViewController, context: Context) {
        // Updates the state of the specified view controller with new information from SwiftUI.
    }
}
