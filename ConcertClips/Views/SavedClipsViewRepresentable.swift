//
//  SavedClipsViewRepresentable.swift
//  ConcertClips
//
//  Created by Vishnu Pathmanaban on 12/7/22.
//

import Foundation

import SwiftUI

struct SavedClipsViewRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = SavedViewController
    
    @ObservedObject var clipsManagerViewModel = ClipsManagerViewModel()
    
    func makeUIViewController(context: Context) -> SavedViewController {
      let vc = SavedViewController()
      return vc
    }
    
    func updateUIViewController(_ uiViewController: SavedViewController, context: Context) {
        // Updates the state of the specified view controller with new information from SwiftUI.
    }
}
