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

// Sarun's
//struct FeedViewRepresentable: UIViewControllerRepresentable {
//    typealias UIViewControllerType = SarunViewController
//
//
////    class Coordinator {
////        var parentObserver: NSKeyValueObservation?
////    }
//
//    func makeUIViewController(context: Context) -> SarunViewController {
//        // Return MyViewController instance
//        print("bananas")
//        let vc = SarunViewController()
//        return vc
//    }
//
//    func updateUIViewController(_ uiViewController: SarunViewController, context: Context) {
//        // Updates the state of the specified view controller with new information from SwiftUI.
//    }
//
////    func makeCoordinator() -> Self.Coordinator { Coordinator() }
//}
