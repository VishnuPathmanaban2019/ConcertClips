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
  @Published var downloadURL: String = ""
  
  func upload (file: URL) -> String {
    let data = Data()
    let storageRef = Storage.storage().reference()
    let videoRef = storageRef.child(file.absoluteString)
    // Upload file and metadata to the object 'images/mountains.jpg'
    let uploadTask = videoRef.putData(data, metadata: nil) { (metadata, error) in
      guard let _ = metadata else {
        // Uh-oh, an error occurred!
        print("error 1")
        return
      }
      // You can also access to download URL after upload.
      videoRef.downloadURL { (url, error) in
        guard let downloadURL = url else {
          // Uh-oh, an error occurred!
          print("error 2")
          return
        }
        print("absolute \(downloadURL.absoluteString)")
        self.downloadURL = downloadURL.absoluteString
        print("self download \(self.downloadURL)")
      }
    }
    uploadTask.observe(.success) { _ in 
      print("in upload \(self.downloadURL)")
      return self.downloadURL
    }
  }
}

