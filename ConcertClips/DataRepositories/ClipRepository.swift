//
//  ClipRepository.swift
//  ConcertClips
//
//  Created by Siddharth Paratkar on 11/5/22.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

class ClipRepository: ObservableObject {
  private let path: String = "clips"
  private let store = Firestore.firestore()

  @Published var clips: [Clip] = []
  private var cancellables: Set<AnyCancellable> = []

  init() {
    self.get()
  }

  func get() {
    store.collection(path)
      .addSnapshotListener { querySnapshot, error in
        if let error = error {
          print("Error getting clips: \(error.localizedDescription)")
          return
        }

        self.clips = querySnapshot?.documents.compactMap { document in
          try? document.data(as: Clip.self)
        } ?? []
      }
  }

  // MARK: CRUD methods
  func add(_ clip: Clip) {
    do {
      let newClip = clip
      _ = try store.collection(path).addDocument(from: newClip)
    } catch {
      fatalError("Unable to add clip: \(error.localizedDescription).")
    }
  }

  func update(_ clip: Clip) {
    guard let clipId = clip.id else { return }
    
    do {
      try store.collection(path).document(clipId).setData(from: clip)
    } catch {
      fatalError("Unable to update clip: \(error.localizedDescription).")
    }
  }

  func remove(_ clip: Clip) {
    guard let clipId = clip.id else { return }
    
    store.collection(path).document(clipId).delete { error in
      if let error = error {
        print("Unable to remove clip: \(error.localizedDescription)")
      }
    }
  }
  
  func getClipFor(_ name: String) -> [Clip] {
    return self.clips.filter{$0.name == name}
  }
  
}
