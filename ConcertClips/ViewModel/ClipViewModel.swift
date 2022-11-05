//
//  ClipViewModel.swift
//  ConcertClips
//
//  Created by Siddharth Paratkar on 11/5/22.
//

import Foundation
import Combine

class ClipViewModel: ObservableObject, Identifiable {

  private let clipRepository = ClipRepository()
  @Published var clip: Clip
  private var cancellables: Set<AnyCancellable> = []
  var id = ""

  init(clip: Clip) {
    self.clip = clip
    $clip
      .compactMap { $0.id }
      .assign(to: \.id, on: self)
      .store(in: &cancellables)
  }

  func update(clip: Clip) {
    clipRepository.update(clip)
  }

  func remove() {
    clipRepository.remove(clip)
  }
}
