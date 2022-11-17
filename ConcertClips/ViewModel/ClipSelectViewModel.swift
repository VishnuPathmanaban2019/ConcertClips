//
//  ClipSelectViewModel.swift
//  ConcertClips
//
//  Created by Siddharth Paratkar on 11/6/22.
//
// Adapted from https://firebase.google.com/docs/storage/ios/upload-files#full_example

import Foundation
import PhotosUI
import FirebaseStorage

class ClipSelectViewModel: ObservableObject {
  
  func upload (file: URL) async throws -> String {
    let storageRef = Storage.storage().reference()
    let videoRef = storageRef.child(file.relativeString)
    // Upload file and metadata to the object 'images/mountains.jpg'
    let _ = videoRef.putFile(from: file, metadata: nil) { (metadata, error) in
      guard let _ = metadata else {
        // Uh-oh, an error occurred!
        print("error 1")
        return
      }
    }
    let downloadURL = try await videoRef.downloadURL()
    print("upload \(downloadURL.absoluteString)")
    return downloadURL.absoluteString
  }
}

