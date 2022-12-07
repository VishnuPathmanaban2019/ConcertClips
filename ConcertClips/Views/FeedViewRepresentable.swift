//
//  FeedViewRepresentable.swift
//  ConcertClips
//
//  Created by Roshan Ram on 11/12/22.
//

import Foundation

import SwiftUI

struct FeedViewRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = ViewController
    
    @ObservedObject var clipsManagerViewModel = ClipsManagerViewModel()
    
    
    func makeUIViewController(context: Context) -> ViewController {
        // Return MyViewController instance
        let vc = ViewController()
        return vc
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        // Updates the state of the specified view controller with new information from SwiftUI.
    }
}
